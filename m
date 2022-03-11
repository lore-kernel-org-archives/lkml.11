Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A41DC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Mar 2022 16:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350131AbiCKQD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Mar 2022 11:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350453AbiCKQDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 11:03:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F9D14CC96
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 08:02:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CC6861AB8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 16:02:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76889C340E9;
        Fri, 11 Mar 2022 16:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647014562;
        bh=e1FLl0t9+zUyxzmV4aYhuGXT4r5FuExzqQASrdPDlrk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ufo3Ram4krI0tK3nu4LiZCIWy6kFE2Wf7/ASM8BODCKYxgUW7Lz1a/mj1jbVCN3/Y
         P+HB8H5UPFUAyoTOfPYkjsJmJbc6N8y/M8cB3dFeXs/vyOjF8SlRE9wbwQT/UKRUER
         B+FegGfWHWylCeAsSfAdSAVdGJtNdI/yWTBsfcbVpHeefeBNRfSy/8i6ocUQjTPMc6
         Iii5Nk5yFoktT/3PoXkDHMrQCSOlwZazGc+Izd9Z3hm+ZfFpw7t9lPYCVRl7iUBT2S
         6HXYNkTB2SijZYS0TM8HubZIylXE7JhYmKb7VKQY6k3lSygxCYXzILcyOLNDrNJMJw
         pq08iqpL5Tisg==
Date:   Fri, 11 Mar 2022 17:02:39 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu Liao <liaoyu15@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 14/19] rcu/context-tracking: Move RCU-dynticks internal
 functions to context_tracking
Message-ID: <20220311160239.GE227945@lothringen>
References: <20220302154810.42308-1-frederic@kernel.org>
 <20220302154810.42308-15-frederic@kernel.org>
 <20220310200705.GA4285@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310200705.GA4285@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 12:07:05PM -0800, Paul E. McKenney wrote:
> On Wed, Mar 02, 2022 at 04:48:05PM +0100, Frederic Weisbecker wrote:
> > Move the core RCU eqs/dynticks functions to context tracking so that
> > we can later merge all that code within context tracking.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> 
> I am not sure that you want rcu_dynticks_task_enter() and friends in
> context tracking, but I have no objection to them living there.  ;-)

I initially tried to keep them in RCU headers but their use of "current"
would imply a circular dependency with sched.h.

Not much appealing alternatives could be:

* macrofying them
* uninline them and keep in RCU

...
