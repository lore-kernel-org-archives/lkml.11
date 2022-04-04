Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9625AC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Apr 2022 15:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378446AbiDDPMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Apr 2022 11:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353885AbiDDPMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 11:12:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9051263C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 08:10:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28E1B615BF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 15:10:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E532C340EE;
        Mon,  4 Apr 2022 15:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649085045;
        bh=o1IeeFgQsjuH+etZt0UbvvPLaipKxod1b5hlYa6R5wA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Ll/pHX1Hv/iFGF9t+umiCmabLWeGavyl/8RJX8yx/QRLSScoAwMceUggyQHXTE4Kd
         //CJX7+6aNA35wRc2Fn0Sg3O0ODeruot9FQfgPk9CKQ25RnzhajtWxc7A34o0usjkZ
         5+Ky+3o83pVOKo55JSHdm2T6LzQyekl5GoELG5incgdGToXQ7x/G/10q1AtFMw0w77
         L2cKcFu7CM0bIe0mY4lArkXvu+0D+WnlYzjmHlZyd6hHJWY7y/wvmM5HM8zesF3fEj
         pUe13g/LqHoM259STF9ibvbQ8gh7slxXHzkWcQZ8pikmloLGeRUOp4LsXo0pHwIVsT
         EtQhNbjVG80NQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 20C345C0370; Mon,  4 Apr 2022 08:10:45 -0700 (PDT)
Date:   Mon, 4 Apr 2022 08:10:45 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [paulmck-rcu:fastexp.2022.04.01a] BUILD REGRESSION
 d9f3e7d671416fdf5b61f094765754269b652db0
Message-ID: <20220404151045.GU4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <62486f05.ithFB6YqfjaeQiXK%lkp@intel.com>
 <20220402161148.GK4285@paulmck-ThinkPad-P17-Gen-1>
 <87fsmtmfpa.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fsmtmfpa.fsf@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 01:40:41PM +0530, Aneesh Kumar K.V wrote:
> "Paul E. McKenney" <paulmck@kernel.org> writes:
> 
> > On Sat, Apr 02, 2022 at 11:43:01PM +0800, kernel test robot wrote:
> >> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git fastexp.2022.04.01a
> >> branch HEAD: d9f3e7d671416fdf5b61f094765754269b652db0  EXP rcu: Move expedited grace period (GP) work to RT kthread_worker
> >> 
> >> Error/Warning reports:
> >> 
> >> https://lore.kernel.org/lkml/202204021454.WDwBbwVL-lkp@intel.com
> >> 
> >> Error/Warning: (recently discovered and may have been fixed)
> >> 
> >> arch/powerpc/include/asm/book3s/64/pgtable-64k.h:60:1: error: no return statement in function returning non-void
> >
> > Adding Aneesh on CC.  My kneejerk reaction would be to add a
> > "return 0" to this function, but there might be a reason why it
> > looks like this:
> 
> yes, that should work. Do you want me to send a patch for this? Or will
> it get folded with other changes?

As far as I know, I won't be touching this file anytime soon.  So
please do send a patch.  ;-)

							Thanx, Paul

> > 	/*
> > 	 * This should never get called
> > 	 */
> > 	static inline int get_hugepd_cache_index(int index)
> > 	{
> > 		BUG();
> > 	}
> >
> > Working on the other problem with RCU's Kconfig options.
> >
> 
> -aneesh
