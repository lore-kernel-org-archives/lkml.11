Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504A7C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Mar 2022 22:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344488AbiCJWxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Mar 2022 17:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237854AbiCJWxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 17:53:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C0CE98FD
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 14:52:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB63CB828AE
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 22:52:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A94C340E8;
        Thu, 10 Mar 2022 22:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646952739;
        bh=4y+t3lSB6PHFNVBGZQpUfWkEuIDxOlJJ1lp91kdOm0s=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=e3pDNUZCRwMG5kxhSm1qkvzzG4nwvvFjfA46JK4bb3C5V4CGvqT3C/cnmFAt0W6V0
         P8dvS0VZu/++BGGsT855pIOOP93ImsPKrNoSAUVNuVR/2okR6NiWDOH27T0MnlG8wf
         xGDOGySaf3Q4O4RcqvPH6DIk0C0VFj7TpTV9gve/4zkkrcCB3yQS8Pz0glDYz2CwK3
         IXQp5B7g9r6qsrO7tg8xweo+dhnUxsbVK4BEbBNmMUorJKzkssOEhYtI1lpE9nJO9s
         JUnb1aZcU2ryp72EFuzSrdcqbAd6oDk4tgjr51MKu8SoVDJJGxudWx+mC8sRKqGdy/
         kXWj43Ytv1DTw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 25C3C5C038D; Thu, 10 Mar 2022 14:52:19 -0800 (PST)
Date:   Thu, 10 Mar 2022 14:52:19 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Scenario TREE07 with CONFIG_PREEMPT_DYNAMIC=n?
Message-ID: <20220310225219.GE4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220310215630.GA3490034@paulmck-ThinkPad-P17-Gen-1>
 <20220310224103.GA94994@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310224103.GA94994@lothringen>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 11:41:03PM +0100, Frederic Weisbecker wrote:
> On Thu, Mar 10, 2022 at 01:56:30PM -0800, Paul E. McKenney wrote:
> > Hello, Frederic,
> > 
> > I recently added CONFIG_PREEMPT_DYNAMIC=n to the TREE07 file, and since
> > then am getting roughly one RCU CPU stall warning (or silent hang)
> > per few tens of hours of rcutorture testing on dual-socket systems.
> > The stall warnings feature starvation of RCU grace-period kthread.
> > 
> > Any advice on debugging this?
> 
> Oh, I'm testing that!

Even better, thank you!  ;-)

							Thanx, Paul
