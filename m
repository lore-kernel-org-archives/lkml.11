Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE39C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Mar 2022 20:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354336AbiCPUUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Mar 2022 16:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241094AbiCPUUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 16:20:02 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659FA33A20
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 13:18:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9DDC3CE1EBF
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 20:18:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70307C340E9;
        Wed, 16 Mar 2022 20:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647461923;
        bh=E8AeDYCKEUVLnBFhVvckKtV5OL+i64pdDnsFZucGNO8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e8AdUGdRwSp1ehdPmZUcKHodP+kLzjOOyN8ZXqoDWLLtswTIew5xlwbDQCe1a6C2o
         HB8rGlquxoYFhbenpd9z/+kyriv0E71YCdnjJV1uHMjQ9IYIXHmu9G4f/AJlBpeTAQ
         A1QLjdf7SmmUH5buLbKMpmKuE2mr58r3o/COxzmABICtgg5AbS/vR9pw8SHw52HbmI
         LSQ4VyIlPowAII+ZOL0J7curlb+0clYWZqqWatSWwc5Ub0G+aOGX31FNw3ajUcAWYN
         13EIePGcWPokAwd95bcNUkJHS+7DtctNuY161htdC6srSFvvZI5v40anDM6l+lHmHN
         pymP9T23GKofQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 003D040407; Wed, 16 Mar 2022 17:18:39 -0300 (-03)
Date:   Wed, 16 Mar 2022 17:18:39 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 'perf stat --null sleep 1' segfault related to
 evlist__for_each_entry with affinity == NULL
Message-ID: <YjJGH8Fzb7Bb22Pt@kernel.org>
References: <YjCLcpcX2peeQVCH@kernel.org>
 <CAP-5=fUW0O2mVopONcTjwYLB6JsLY8HgGzggj=zw7R45wBhozA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUW0O2mVopONcTjwYLB6JsLY8HgGzggj=zw7R45wBhozA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 16, 2022 at 12:14:12AM -0700, Ian Rogers escreveu:
> On Tue, Mar 15, 2022 at 5:50 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > And was dormant as the affinity was being always setup, which we don't
> > want when it isn't needed.
> 
> Thanks for the detailed report, I sent a fix in:
> https://lore.kernel.org/lkml/20220316071049.2368250-1-irogers@google.com/
> Any thoughts for a shell test to avoid this regressing again in the future?

Thanks for providing me with the Message-ID, that way I'll be able to
get that patch since I wasn't on the CC list for it, I'll also add a
Reported-by tag.

- Arnaldo
