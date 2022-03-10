Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239DAC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Mar 2022 21:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344151AbiCJV5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Mar 2022 16:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbiCJV5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 16:57:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8669C194161
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 13:56:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F4B361ABC
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:56:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE7CC340E8;
        Thu, 10 Mar 2022 21:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646949391;
        bh=tHqqZoN5V/pTylUhmIkFz15bLrEsHWmQ2/dfqbQN7+A=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=qPcZiBW27QLZULCGwSe0a+ul5McP0faBu7W1A+tlRVe+10vpMqIw7MZk8Vn8pk6GR
         iPiuNEWC5WirNE4ttHDqK8zEYbufbxaeYNjvuCHqJezcpH3MY3WRYhq6LzXTd63jXk
         o3ce1qbll/FQzhQT7RF5sMro5899jDcN7KMDmzMqbWpjDYUd2dFCjdOWeExchEF9Bg
         QvMIypC+sShINpEv/J5TGnLILhXJISlzcIilNpd+QXb+0MTGTc7aEe+wR2AhXVgmYI
         s7DM+y5tE9x6wx2+nxXrpHKrEt+fRWPxnHDJirik1Bru6jM0N59D7btbBPfzenylgR
         SRVHxrjlH67Qw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 036895C038D; Thu, 10 Mar 2022 13:56:31 -0800 (PST)
Date:   Thu, 10 Mar 2022 13:56:30 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     frederic@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Scenario TREE07 with CONFIG_PREEMPT_DYNAMIC=n?
Message-ID: <20220310215630.GA3490034@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Frederic,

I recently added CONFIG_PREEMPT_DYNAMIC=n to the TREE07 file, and since
then am getting roughly one RCU CPU stall warning (or silent hang)
per few tens of hours of rcutorture testing on dual-socket systems.
The stall warnings feature starvation of RCU grace-period kthread.

Any advice on debugging this?

							Thanx, Paul
