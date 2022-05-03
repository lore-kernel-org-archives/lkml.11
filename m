Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75886C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 May 2022 15:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238855AbiECQCz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 May 2022 12:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238803AbiECQCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 12:02:53 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AD13C722
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 08:59:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EE608CE1E2F
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 15:59:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37067C385A4;
        Tue,  3 May 2022 15:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651593558;
        bh=XY9ch2qBQz1SEgroJDBDxJ7tbxMsdOzqeG8iF4Vg6NA=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=j51WGuTq2KD/fLVJmuUDFZe+OZdWlAv8lR3nxVgu+whTaECowisgCxpMK7kYHvjo7
         hMee1gp1pLguQI0tuxugGNPQcOkcl4vX5MpuH2efetRFWh0F6qOkcahZQFDaqnLOBP
         90Pgrsy3CtA6Dx/y9sp7axtpqPASAG5tmz6jsoIUv79pV7KPq6V2oh72kM4Y4qVHPw
         b4OOBDRWHrvs/YLISULk0upIqPoN0nHAJTqylDO/aPa3KjayQ6OnEcLCedZJ0hjh+Z
         I37cepvKUZKOWILyaTJVa6bXzJHD0sjkB9rarzL2oKySkt3T0cOtWd9rEQv8+hQjbM
         lsYTkvd69L0qA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0F0AA5C0115; Tue,  3 May 2022 08:59:13 -0700 (PDT)
Date:   Tue, 3 May 2022 08:59:13 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     liam.howlett@oracle.com, willy@infradead.org, walken.cr@gmail.com,
        mhocko@suse.com, hannes@cmpxchg.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Memory allocation on speculative fastpaths
Message-ID: <20220503155913.GA1187610@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Just following up from off-list discussions yesterday.

The requirements to allocate on an RCU-protected speculative fastpath
seem to be as follows:

1.	Never sleep.
2.	Never reclaim.
3.	Leave emergency pools alone.

Any others?

If those rules suffice, and if my understanding of the GFP flags is
correct (ha!!!), then the following GFP flags should cover this:

	__GFP_NOMEMALLOC | __GFP_NOWARN

Or is this just a fancy way of always returning NULL or some such?  ;-)

							Thanx, Paul
