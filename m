Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0601FC4332F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Mar 2022 16:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237283AbiCIQxS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Mar 2022 11:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235948AbiCIQpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:45:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A99AEFF8E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 08:40:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05C2A61A59
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 16:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F27C340E8;
        Wed,  9 Mar 2022 16:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646844022;
        bh=+5OBDCAPlysWrokS+x8OkNlrTTiQJPMsyVnddkAbhok=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ea7im7MIkxGIK3xcNfboSU0lpvSMbjxV0JR7KDs5g76IUWNbW/ncIzrawYSgpnh/H
         vR0GgqdhxgKn+ncB6fXo7B9WcB8W2RUg+Qrr6Koy4jIQTvjba0kvQSGJQxb0QuKmaf
         tFSuxyixp2dfwO0WP8K+ThPUUDQ39bbmgikxks55rmqu4eTq+771geloHbbufdjhrK
         oiisvmwynZniqCE4OduUeIvnu6PoNnh1ucwFjwoHtHNzcilQurx1dPTlUX5RseXr9e
         VpcXq4DxafJ2EIuO/igj9quodDOdmDZJUkL61mY/s0sdWgZaOm5HoDTMrJqK3MNG8W
         VsCDyZs1ci6WQ==
Message-ID: <465c71e018de9800ba22a84b9c16f56f99aabefd.camel@kernel.org>
Subject: Re: [PATCH 15/19] rcu/context-tracking: Remove unused and/or
 unecessary middle functions
From:   nicolas saenz julienne <nsaenz@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu Liao <liaoyu15@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 09 Mar 2022 17:40:15 +0100
In-Reply-To: <20220302154810.42308-16-frederic@kernel.org>
References: <20220302154810.42308-1-frederic@kernel.org>
         <20220302154810.42308-16-frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-03-02 at 16:48 +0100, Frederic Weisbecker wrote:
> Some eqs functions are now only used internally by context tracking, so
> their public declarations can be removed.
> 
> Also middle functions such as rcu_user_*() and rcu_idle_*()
> which now directly call to rcu_eqs_enter() and rcu_eqs_exit() can be
> wiped out as well.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Nicolas Saenz Julienne <nsaenz@kernel.org>
> Cc: Marcelo Tosatti <mtosatti@redhat.com>
> Cc: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> Cc: Yu Liao<liaoyu15@huawei.com>
> Cc: Phil Auld <pauld@redhat.com>
> Cc: Paul Gortmaker<paul.gortmaker@windriver.com>
> Cc: Alex Belits <abelits@marvell.com>
> ---

You missed rcu_user_{enter,exit} declarations in rcupdate.h

There are also comments refering to them in kernel/context_tracking.c and
Documentation/RCU/stallwarn.rst.

Regards,
Nicolas
