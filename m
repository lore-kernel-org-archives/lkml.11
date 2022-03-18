Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65380C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Mar 2022 11:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbiCRLIa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Mar 2022 07:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235685AbiCRLIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 07:08:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302FAF3A56
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 04:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BHBH8G96Ps/oE0eH+Ie+X9ErNpzL4QXTbqriBTJrVKk=; b=njRAng050Xf1a5ONze/STK/SHg
        sBeENvKFl8UJ1F41CkMLNVd/9Ulf8dx5qDHhrjm83cADTQOzfF4tXgy0tIlM1aTvL3jBKOpPGGdVw
        wlV+lOvT8b0XQQ1nySM+Id7xg04PqdrUkUNhh1Bg2X6nzGPZvx7g64pn15JIExYdCqx4N+VynX4/X
        r+mrOMSZSeGOIsMNoWs6mpR0e/btLuTJgEclO82x8MfXIRIJHSii6S9iJJLUKgexQnaO7gAVXnO8h
        sritbc4HJxox1TQNApPytg/TT83xu7iAtqyrVEDaoXhv6NZsU8TgpdCASvnLWcdSXAuNvm9XUkbIN
        D7pmmKMw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nVARY-002Btl-Dr; Fri, 18 Mar 2022 11:06:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 109453001EA;
        Fri, 18 Mar 2022 12:06:52 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E6A602D35E98E; Fri, 18 Mar 2022 12:06:51 +0100 (CET)
Date:   Fri, 18 Mar 2022 12:06:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/4] perf/x86: Add Intel Raptor Lake support
Message-ID: <YjRny2qPtal2Y/Hj@hirez.programming.kicks-ass.net>
References: <1647366360-82824-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1647366360-82824-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 10:45:57AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> From PMU's perspective, Raptor Lake is the same as the Alder Lake. The
> only difference is the event list, which will be supported in the perf
> tool later.

Thanks!
