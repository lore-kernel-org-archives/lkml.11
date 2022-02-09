Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34F6C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Feb 2022 11:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbiBILzU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Feb 2022 06:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbiBILzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 06:55:11 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79167C05CBA9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 02:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GkFncH3D98WWU5j3nygIVV9IJgCRQDVabHsVvuLcQhI=; b=LZ3304J7qWfUhOQlgypmXiZFvV
        aB0eujBTl0pmXDqJeC3qOxUcZX1ceBDfZ4yuTS11NaiY+RxMAuRHEtaxcpB6DYwr44vXuDfE/4aMF
        jsAWsUNa3Zh9NstE0JlF71q1QEK+VUmFFYMZ0EUMDk3DjdLuzvMa5zfGZspbMn19LBGw3U2ptwSX4
        34XBtqYGi2AwEtiV+rVaaoPNkEAHtIQclSmnn6eKmShM4siOBTALEyiNpL8rVlYQlwgYjfCA4XKzm
        rc1ZJwyV7UMGOe7qDgm3iBjqr9Y/GWsznQNQsvXo2FwezdLweWGw99/tSt+djHd05YxK5bi7J3a6d
        XABezw/g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHkUV-008Os7-Hf; Wed, 09 Feb 2022 10:46:28 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B098A9853C7; Wed,  9 Feb 2022 11:46:25 +0100 (CET)
Date:   Wed, 9 Feb 2022 11:46:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     aubrey.li@linux.intel.com, efault@gmx.de, gautham.shenoy@amd.com,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        mingo@kernel.org, song.bao.hua@hisilicon.com,
        srikar@linux.vnet.ibm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org
Subject: Re: [PATCH] sched/fair: Consider cpu affinity when allowing NUMA
 imbalance in find_idlest_group
Message-ID: <20220209104625.GM23216@worktop.programming.kicks-ass.net>
References: <20220207155921.21321-1-kprateek.nayak@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207155921.21321-1-kprateek.nayak@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 09:29:21PM +0530, K Prateek Nayak wrote:
> Neither the sched/tip nor Mel's v5 patchset [1] provides an optimal
> new-task wakeup strategy when the tasks are affined to a subset of cpus
> which can result in piling of tasks on the same set of CPU in a NUMA
> group despite there being other cpus in a different NUMA group where the
> task could have run in. 

Where does this affinity come from?
