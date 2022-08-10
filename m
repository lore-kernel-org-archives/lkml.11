Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09322C00140
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Aug 2022 17:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbiHJRkd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Aug 2022 13:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiHJRka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 13:40:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2A1550B1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 10:40:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA7C7613E9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 17:40:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 030D7C433C1;
        Wed, 10 Aug 2022 17:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660153228;
        bh=nFJQxomUh9KTHwScsJk2d45OnI0XqJfT8iv+QgI0DCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t86dXLq6U0jQ0NbmsSk2SMYj6T6M/gntZTYucCeKLCyHJoLc1w/xt+hQI6bX5UzQ0
         u0qMPwvJVcMM1RZLIX2/9TwZuINM64Gym9YxmPJhChzmzMkW0lICrrkYftwW/YbbG7
         hIex14W5oeN7KS7hvwXe6lC7rBQIxpoFTCVENkAQoP6NWbQqvCsU6/oGbhh/7uRSG+
         UFeJBPY5GJAR9BWkkX0zDAdP+LCwz42XOKoHaaOP+vI7nS/4Jwu2a9Vy/wipWEYEM+
         efTpP2RYXRmEtFohBUbDh2ezHzyF2W7/OQsRxGPEftVBiksasHnlPPGM+nwEXWNmrQ
         HYStKU+KnkL9A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 66BEB4035A; Wed, 10 Aug 2022 14:40:25 -0300 (-03)
Date:   Wed, 10 Aug 2022 14:40:25 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/3] perf tests: Fix Track with sched_switch test for
 hybrid case
Message-ID: <YvPtib5Aslem+gtZ@kernel.org>
References: <20220809080702.6921-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809080702.6921-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 09, 2022 at 11:06:59AM +0300, Adrian Hunter escreveu:
> Hi
> 
> Here are a couple of fixes (V2) related to the Track with sched_switch test,
> and a subsequent tidy-up.
> 
> 
> Changes in V2:
> 
>       perf parse-events: Fix segfault when event parser gets an error
> 	Amend commit message to refer to subsequent tidy-up patch
> 
>       perf tools: Do not pass NULL to parse_events()
> 	New patch

Thanks, applied to my local branch.

- Arnaldo

 
> 
> Adrian Hunter (3):
>       perf parse-events: Fix segfault when event parser gets an error
>       perf tests: Fix Track with sched_switch test for hybrid case
>       perf tools: Do not pass NULL to parse_events()
> 
>  tools/perf/arch/arm/util/cs-etm.c       |  2 +-
>  tools/perf/arch/arm64/util/arm-spe.c    |  2 +-
>  tools/perf/arch/x86/tests/intel-cqm.c   |  2 +-
>  tools/perf/arch/x86/util/intel-bts.c    |  2 +-
>  tools/perf/arch/x86/util/intel-pt.c     |  2 +-
>  tools/perf/arch/x86/util/iostat.c       |  2 +-
>  tools/perf/arch/x86/util/topdown.c      |  2 +-
>  tools/perf/tests/code-reading.c         |  2 +-
>  tools/perf/tests/event-times.c          |  2 +-
>  tools/perf/tests/evsel-roundtrip-name.c |  4 ++--
>  tools/perf/tests/hists_cumulate.c       |  2 +-
>  tools/perf/tests/hists_filter.c         |  4 ++--
>  tools/perf/tests/hists_link.c           |  4 ++--
>  tools/perf/tests/hists_output.c         |  2 +-
>  tools/perf/tests/keep-tracking.c        |  4 ++--
>  tools/perf/tests/perf-time-to-tsc.c     |  2 +-
>  tools/perf/tests/switch-tracking.c      | 24 ++++++++++++++++--------
>  tools/perf/util/bpf-loader.c            |  2 +-
>  tools/perf/util/parse-events.c          | 22 ++++++++++++++++++----
>  tools/perf/util/parse-events.h          |  4 ++++
>  tools/perf/util/perf_api_probe.c        |  2 +-
>  tools/perf/util/record.c                |  2 +-
>  22 files changed, 61 insertions(+), 35 deletions(-)
> 
> 
> Regards
> Adrian

-- 

- Arnaldo
