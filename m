Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E07C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Jul 2022 17:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiGERUq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Jul 2022 13:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbiGERUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 13:20:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D293140B4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 10:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S+E47bWcrWV9KBgCllYoKidtSNcUgrYwh//SMMW7IQg=; b=pZOjYCxChlRKT9cai2wqwr5Fvz
        WoAkakVqqk4X7Pji3bPKqWApeKzzoDnnlQsgVBitOtSm82KyYFqE2f/7nJV4cc7YNbBnHx18Cn8JY
        KnUpGbT4X/CRkJYltzJhyk4f2qatPSYJ5EHDK/HifrqqFOnlmcELAEYsiL3dHCGyjfv2EZHwq/s6k
        d0aF9QNiJk2GpU09BQmZ9S91F+IX6Bk7lkJODB5BG3hu/YuRkD5wxRCmB6THxT38DEItUvHlQ7KJr
        GHMlRX0vFqOlqlnGz2Ah7yIOsRrS7qBjXXmFU1zFHiZFPLtTlyIu0GJBne8qOH/YSjdCw66FWdMFN
        GIpLlDdg==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8mE1-000lye-Ea; Tue, 05 Jul 2022 17:20:37 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 04F0E980059; Tue,  5 Jul 2022 19:20:36 +0200 (CEST)
Date:   Tue, 5 Jul 2022 19:20:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/13] locking/qspinlock: merge qspinlock_paravirt.h into
 qspinlock.c
Message-ID: <YsRy5HHdHhRz9z/9@worktop.programming.kicks-ass.net>
References: <20220704143820.3071004-1-npiggin@gmail.com>
 <20220704143820.3071004-7-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704143820.3071004-7-npiggin@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 12:38:13AM +1000, Nicholas Piggin wrote:
> There isn't much reason to keep these separate.

The reason was so that other paravirt implementations could be added.

The CNA thing was also implemented this way...
