Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F7EC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Feb 2022 16:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351825AbiBKQwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Feb 2022 11:52:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242214AbiBKQwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:52:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C1A8D
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 08:52:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C79E618B0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 16:52:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4973C340E9;
        Fri, 11 Feb 2022 16:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644598364;
        bh=dQVZHOWp9O4+aAda6/oe3UBoykyAyCKAPb30XTe1pLc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q8svW3QV4j1QSyUb/NCIxLI7+WYpA2NBiUaEQJ2kuVYhQARuZ5JoelAujthaqLvTf
         4M4l8ciFxQxQ3V70J0Zlce+pOHm41c/+VaZxN3meNj07xZ6SyMnmv9HNkCUjcEEcbD
         T2MQ8a+9K0IN8vSvN+/iTeqhE/06iVztqsJwrppIIJvmRTKOtzHKCdjA1sxGPeNL4W
         vXh+ePKZmGd2u6q3tdBCKraP/lGXO7FDm6tUmnjxJ9leLgnrZzoFG4TBFcYebIqWyL
         +plOdMtwehreB/RtN/FeBt9p3BU5DPN0CyBqf0njdli7zEmKyYqP9PwPEjA7zH9/ON
         /jDxlpUcEz7AQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 177DE400FE; Fri, 11 Feb 2022 13:52:42 -0300 (-03)
Date:   Fri, 11 Feb 2022 13:52:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: Re: [PATCH v13 03/16] perf record: Introduce thread specific data
 array
Message-ID: <YgaUWoQ+LRrDaAAP@kernel.org>
References: <cover.1642440724.git.alexey.v.bayduraev@linux.intel.com>
 <fc9f74af6f822d9c0fa0e145c3564a760dbe3d4b.1642440724.git.alexey.v.bayduraev@linux.intel.com>
 <YfhXG5yEHhrGDjvl@kernel.org>
 <Yfhg1zH9rQ3lBP9N@kernel.org>
 <YgaUA4O2wvFFeeQJ@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgaUA4O2wvFFeeQJ@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 11, 2022 at 01:51:16PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Jan 31, 2022 at 07:21:11PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Mon, Jan 31, 2022 at 06:39:39PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Some changes to reduce patch size, I have them in my local tree, will
> > > publish later.
> > 
> > Its in perf/threaded at:
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
> > 
> > Will continue tomorrow, testing it and checking the speedups on my
> > 5950x, I think the things I found so far can be fixed in follow up
> > patches, to make progress and have this merged sooner.
> > 
> > I'll try and add committer notes with the test for some 'perf bench'
> > workload without/with parallel recording, something I missed in your
> > patch descriptions.
> 
> Didn't manage to do that, but my considerations are minor at this point
> and plenty of informed people acked, reviewed, tested, so I'm not going
> to be the one to prevent this from going upstream.
> 
> If we find problems (oh well), we'll fix it and progress.
> 
> Thank you, Alexei Budankov, Jiri, Namhyung and Riccardo for working on
> making perf scale at the record phase for so long,
> 
> I'm pushing this to perf/core, that should get into 5.18.
> 
> Also, as a heads up, I'll change 'perf/core' to 'perf/next', to align
> with the kool kids out there,

Something I forgot to add: the current codebase, with this patchset,
passes 'perf test' and 'make -C tools/perf build-test' and also all the
container build tests on a myriad of distros.

- Arnaldo
