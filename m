Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E49C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 May 2022 08:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235861AbiEIIZ4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 May 2022 04:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236025AbiEIIPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 04:15:36 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8728134E27
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 01:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wKFmhrP3WzJLDbdv59rm6WBSkcF7RLZCEwBXG20oLYE=; b=GSkcMaBNEadXEJdb8WkyJrrUKh
        YgemITSvEkkzI312GJ6/E9gL8QWQ6DA3xOK8TlkV1/DjftLPGKygWzUCT7AHhVW/IsB5i6c9fy75T
        RCjV4rUXOGHSSaGNt8zysF91fe+3E3Gf4CjUe2CChbmeG81c6CNTTFRf28PfGH0M2qniI25lRcium
        4w8f068Fjsf1EP6cAoxuNWVdj+BRzfaoBYx/DanZ7hBOZ7tIJV+M2PnoKH2DA8cKkOzQe1A4Q5dTV
        HY8jNsw2pJlpZK44P+dMDijPXiz48NhIPhk+u0kFFf0/fZjgc1a9GSUgliPvr3SEjxVKufO2seIvx
        S1kYXmBQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnyRH-00CV35-LD; Mon, 09 May 2022 08:08:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 39961300385;
        Mon,  9 May 2022 10:08:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 11E5A2026968A; Mon,  9 May 2022 10:08:17 +0200 (CEST)
Date:   Mon, 9 May 2022 10:08:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Hao Jia <jiahao.os@bytedance.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] sched/core: Avoid obvious double update_rq_clock
 warning
Message-ID: <YnjL8UQ1ejVnsMG6@hirez.programming.kicks-ass.net>
References: <20220430085843.62939-1-jiahao.os@bytedance.com>
 <20b9822d-4a87-c868-1683-30b0a7e97777@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20b9822d-4a87-c868-1683-30b0a7e97777@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 11:16:39AM +0800, Hao Jia wrote:
> Friendly ping...
> 
> Hi Dietmar Eggemann & Peter Zijlstra,
> If you have time, please review these two patches.

I've picked them up, shall push them to tip soonish.

Thanks!
