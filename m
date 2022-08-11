Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9CEC25B07
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Aug 2022 21:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235867AbiHKVuu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Aug 2022 17:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233840AbiHKVuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 17:50:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C15F79
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 14:50:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86501614FB
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 21:50:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13F2C433D6;
        Thu, 11 Aug 2022 21:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660254643;
        bh=hnDv3iBKRA+CY+pdRVVQGofhDrmfNE2bQVvt3Ph5COw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ACYufIQ2xgkbgfa2rcIFXj2wVPnyy7Q298IRfOi8B6WiCLEa/1DFDo5I3It3w9/wp
         HrC5OR2sc4JyWget2BZIrfA+yXFzQHuNP26EcHJaHZzFqiagPPnLwLHwtv+XswE/Qh
         R4JwddlQlhIwhnPYPXDGihIFQSUmAFj8PHUHc0UtVbHT9v2P3MQ+rI3Rd0RDY3z2ZI
         QTfF+xs24cC3JxVJLMHkynjl8kzT5r//gU+U2Bqht2o7SJanTVznTqGIQY1/A2rS1Q
         XGV2G+EGgtW3iGrzKhhhcDtoHhMdeYC/ZHn3rjFGg5ShlWbZLcYxwoSgtJ3QXMHXN3
         fzQFzhfam8etQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 173BD4035A; Thu, 11 Aug 2022 18:50:41 -0300 (-03)
Date:   Thu, 11 Aug 2022 18:50:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] perf tools: Fix missing guest option documentation
Message-ID: <YvV5saVtSfG+ZdbJ@kernel.org>
References: <20220811170411.84154-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811170411.84154-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 11, 2022 at 08:04:08PM +0300, Adrian Hunter escreveu:
> Hi
> 
> Here are a couple of small documentation fixes and subsequent corresponding
> tidy-up.

Thanks, applied.

- Arnaldo

 
> 
> Adrian Hunter (3):
>       perf script: Fix missing guest option documentation
>       perf inject: Fix missing guestmount option documentation
>       perf tools: Tidy guest option documentation
> 
>  tools/perf/Documentation/guest-files.txt | 16 ++++++++++++++++
>  tools/perf/Documentation/guestmount.txt  | 11 +++++++++++
>  tools/perf/Documentation/perf-inject.txt |  4 ++++
>  tools/perf/Documentation/perf-kvm.txt    | 25 +++++--------------------
>  tools/perf/Documentation/perf-script.txt |  6 +++---
>  5 files changed, 39 insertions(+), 23 deletions(-)
>  create mode 100644 tools/perf/Documentation/guest-files.txt
>  create mode 100644 tools/perf/Documentation/guestmount.txt
> 
> 
> Regards
> Adrian

-- 

- Arnaldo
