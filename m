Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC84CC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 May 2022 18:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348595AbiEZSYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 May 2022 14:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345974AbiEZSX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 14:23:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD7F37A2D
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 11:23:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B9D3B821AA
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 18:23:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10634C385A9;
        Thu, 26 May 2022 18:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653589434;
        bh=2iPP/ToEyBvLHbKXiR3D+2eq8C5dBc57eaBKfnIkpjg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=knNKHGVMdmBsCR4qyDHj6Qim7hgCka6qXaSXImW1ehS1PL0/Gt3VzxiIaJixyi7Ov
         vnjzQdjkJcUDQ1A+Uu6usYb1xiPmwKubZ+f5Xy3Ia15rBYpm67jbGZw5oJhb0K3S7Q
         ZRd+mq3xXOB4WyL2oFiNLh6YOhYR8s0VH5zP4Qbz3nFyOLWi6eujOkbzsQCVKNCiRp
         dQwaMIBkObymDj9HqMjtRRhcd+wEkucEsdr0a+SRkxP74yPt/pCr91u98zWryIfe7Y
         UuhfnA744yDpKOslpXv5Yw4QM4v75jJ3IadYBLwsCi3Zup4Rba8+AMJ2jX7IL7Tgbr
         0p1SAEEPC6/6w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B924B4036D; Thu, 26 May 2022 15:23:51 -0300 (-03)
Date:   Thu, 26 May 2022 15:23:51 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Brown, Len" <len.brown@intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        "Pawnikar, Sumeet R" <sumeet.r.pawnikar@intel.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [FYI PATCH 1/1] tools arch x86: Sync the msr-index.h copy with
 the kernel sources
Message-ID: <Yo/Ft1msmmqb2gpX@kernel.org>
References: <Yo+i/j5+UtE9dcix@kernel.org>
 <1b985724110640719b4073e1bbec07d5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b985724110640719b4073e1bbec07d5@intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 26, 2022 at 04:50:47PM +0000, Luck, Tony escreveu:
> Sorry for being part of the problem with this getting out of sync.

There is no problem to be sorry for :-)
 
> But, remind me again why tools has *copies* of this and other files.

We used not to have copies, using kernel headers directly. From time to
time tools/perf broke due to legitimate kernel hacking. At some point
Linus complained about such direct usage. Then we adopted the current
model.

The way these headers are used in perf are not restricted to just
including them to compile something. There are, as described in the log
message for this sync, scripts that convert defines into string tables,
etc, so some change may break one of these scripts, or new MSRs may use
some different #define pattern, etc.

Having the tools/perf/check-headers.sh script, part of building tools,
point out new changes in the original files lets people check what
happened and sometimes just do as I did, update.
 
>o Seems like pointless work to keep them in sync.

I hope to have clarified.

- Arnaldo
