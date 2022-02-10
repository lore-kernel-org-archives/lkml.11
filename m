Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAB7C433FE
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Feb 2022 11:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236706AbiBJL5b (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Feb 2022 06:57:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236181AbiBJL52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 06:57:28 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AD6262F;
        Thu, 10 Feb 2022 03:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644494248; x=1676030248;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aUDTUwtDlGMi21r3TDkZxoQ2hVhLGhZaFoI/YDySAPc=;
  b=D8ZRPRpTTwN5kYrlOdAwljpuSS1ZDXZye+DognHDF2najUMPY9vitIcD
   HtI7iRXQ6JOMnmQcVj95ZSiByeJ7n/YCzNMszLauijCDoIF00V+824FLZ
   EGtOVyEcv105cWUHeQzoPaOzUr3mynbAdg3mFbf+pgMQHBkduutrkPydm
   8gxb3edFoob/xjMj8rrCxm0ckJGux9K97M1aa9l96vfCKb4xM58hn0Fvx
   HKECrZ1O5f/LLlU4RY/JnL5qpxgb4hrl2+5Kb1yYsxxSDA19y3001GgYg
   irELzoKmnf5FtyiX/He/mD1qK1IaVqhbMI9Lujf2sk8QJeQnCkiYVy9oC
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="249225612"
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="249225612"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 03:57:27 -0800
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="541577635"
Received: from chenyu-dev.sh.intel.com (HELO chenyu-dev) ([10.239.158.61])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 03:57:25 -0800
Date:   Thu, 10 Feb 2022 19:56:53 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     intel-wired-lan@osuosl.org, Len Brown <len.brown@intel.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Todd Brandt <todd.e.brandt@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [Intel-wired-lan] [PATCH] e1000e: Print PHY register address
 when MDI read/write fails
Message-ID: <20220210115653.GA53223@chenyu-dev>
References: <20220209234302.50833-1-yu.c.chen@intel.com>
 <c496b425-7e8a-a0d9-b27a-990b54743a01@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c496b425-7e8a-a0d9-b27a-990b54743a01@molgen.mpg.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul, thanks for the review,
On Wed, Feb 09, 2022 at 05:54:25PM +0100, Paul Menzel wrote:
> Dear Chen,
> 
> 
> First, your system time is incorrect, and the message date from the future.
> 
I did not realize this after the system been re-installed recently,
thanks for reminding me.
> 
> Am 10.02.22 um 00:43 schrieb Chen Yu:
> > There is occasional suspend error from e1000e which blocks the
> > system from further suspending:
> 
> Please add a blank line here.
>
Ok.
> Also, please document the specific board/configuration in question.
> 
Ok.
> > [   20.078957] PM: pci_pm_suspend(): e1000e_pm_suspend+0x0/0x780 [e1000e] returns -2
> > [   20.078970] PM: dpm_run_callback(): pci_pm_suspend+0x0/0x170 returns -2
> > [   20.078974] e1000e 0000:00:1f.6: PM: pci_pm_suspend+0x0/0x170 returned -2 after 371012 usecs
> > [   20.078978] e1000e 0000:00:1f.6: PM: failed to suspend async: error -2
> 
> Please add a blank line her.e
> 
Ok.
> > According to the code flow, this might be caused by broken MDI read/write to PHY registers.
> > However currently the code does not tell us which register is broken. Thus enhance the debug
> > information to print the offender PHY register for easier debugging.
> 
> Please reflow for 75 characters per line, and maybe even paste the new
> messages, if you have a system, where you can reproduce that on.
> 
Ok, will do.

Thanks,
Chenyu
> > Reported-by: Todd Brandt <todd.e.brandt@intel.com>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> >   drivers/net/ethernet/intel/e1000e/phy.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/e1000e/phy.c b/drivers/net/ethernet/intel/e1000e/phy.c
> > index 0f0efee5fc8e..fd07c3679bb1 100644
> > --- a/drivers/net/ethernet/intel/e1000e/phy.c
> > +++ b/drivers/net/ethernet/intel/e1000e/phy.c
> > @@ -146,11 +146,11 @@ s32 e1000e_read_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 *data)
> >   			break;
> >   	}
> >   	if (!(mdic & E1000_MDIC_READY)) {
> > -		e_dbg("MDI Read did not complete\n");
> > +		e_dbg("MDI Read PHY Reg Address %d did not complete\n", offset);
> >   		return -E1000_ERR_PHY;
> >   	}
> >   	if (mdic & E1000_MDIC_ERROR) {
> > -		e_dbg("MDI Error\n");
> > +		e_dbg("MDI Read PHY Reg Address %d Error\n", offset);
> >   		return -E1000_ERR_PHY;
> >   	}
> >   	if (((mdic & E1000_MDIC_REG_MASK) >> E1000_MDIC_REG_SHIFT) != offset) {
> > @@ -210,11 +210,11 @@ s32 e1000e_write_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 data)
> >   			break;
> >   	}
> >   	if (!(mdic & E1000_MDIC_READY)) {
> > -		e_dbg("MDI Write did not complete\n");
> > +		e_dbg("MDI Write PHY Reg Address %d did not complete\n", offset);
> >   		return -E1000_ERR_PHY;
> >   	}
> >   	if (mdic & E1000_MDIC_ERROR) {
> > -		e_dbg("MDI Error\n");
> > +		e_dbg("MDI Write PHY Red Address %d Error\n", offset);
> >   		return -E1000_ERR_PHY;
> >   	}
> >   	if (((mdic & E1000_MDIC_REG_MASK) >> E1000_MDIC_REG_SHIFT) != offset) {
> 
> Acked-by: Paul Menzel <pmenzel@molgen.mpg.de>
> 
> 
> Kind regards,
> 
> Paul
