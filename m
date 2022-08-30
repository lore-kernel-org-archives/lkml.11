Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB0BC0502A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Aug 2022 20:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiH3UEX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Aug 2022 16:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiH3UEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 16:04:02 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDF18050B;
        Tue, 30 Aug 2022 13:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661889774; x=1693425774;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g2RcCvs3gTcJdjLoDdcHmbRTjlqKmHEueIsD0OrLV1Y=;
  b=VjoWghZOf9C6eMEO//kPBXfEMA4FNMHb3Ye5Zw231QiqVNPMzsbD2YZx
   ZcrzFNXigAI6vh9BmHznDMs5OwOItkspC3xXt7aA9Fs7q3aLRgY1lcDO/
   e2Rz2nhe/A5UkBesKEM8GPVDmtD3maWFqpf3FVevdayZcr0Au2GrWWeWW
   sD5PU/UKmfD+LWRGV7dVqzknv/62vj+EJCStijkBG/A2RdgvKuyurNrPN
   2Joqd6g154tsqXoo5WOx128UGad8JN+JFhB4zGwS9LLh4+/+qzfpkOneG
   XwDdyHglTxVp1f2EOV9dvvCkFmjyBfk2CxzDmivOjnmd1TRP0dSOpfO+I
   w==;
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="178376952"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Aug 2022 13:02:52 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 30 Aug 2022 13:02:46 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Tue, 30 Aug 2022 13:02:46 -0700
Date:   Tue, 30 Aug 2022 22:07:02 +0200
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH v2 2/2] nvmem: lan9662-otp: add support.
Message-ID: <20220830200702.noefi7q5syrsgh52@soft-dev3-1.localhost>
References: <20220825204041.1485731-1-horatiu.vultur@microchip.com>
 <20220825204041.1485731-3-horatiu.vultur@microchip.com>
 <4788e399-b292-9da7-3d62-75bb0312d4b9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <4788e399-b292-9da7-3d62-75bb0312d4b9@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 08/30/2022 13:08, Srinivas Kandagatla wrote:
> 
> > +static inline void lan9662_writel(void __iomem *addr, u32 val)
> > +{
> > +     writel(val, addr);
> > +}
> > +
> > +static inline u32 lan9662_readl(void __iomem *addr)
> > +{
> > +     return readl(addr);
> > +}
> > +
> 
> Why these boiler plate functions?

It was more for the style purpose. I will remove these ones.

> 
> > +static inline void lan9662_clrbits(void __iomem *addr, u32 clear)
> > +{
> > +     writel(readl(addr) & ~clear, addr);
> > +}
> > +
> > +static inline void lan9662_setbits(void __iomem *addr, u32 set)
> > +{
> > +     writel(readl(addr) | set, addr);
> > +}
> 
> These two functions are called just once and I see no point in having a
> wrapper function for this, instead you could use them directly or use
> ./include/linux/bitfield.h helper macros.

I will remove also these ones and use them directly.

> 
> > +
> > +static bool lan9662_otp_wait_flag_clear(void __iomem *reg, u32 flag)
> > +{
> > +     u32 val;
> > +
> > +     return readl_poll_timeout(reg, val, !(val & flag),
> > +                               OTP_SLEEP_US, OTP_TIMEOUT_US);
> > +}
> > +
> > +static int lan9662_otp_power(struct lan9662_otp *otp, bool up)
> > +{
> > +     if (up) {
> > +             lan9662_clrbits(OTP_OTP_PWR_DN(otp->base),
> > +                             OTP_OTP_PWR_DN_OTP_PWRDN_N);
> > +             if (lan9662_otp_wait_flag_clear(OTP_OTP_STATUS(otp->base),
> > +                                             OTP_OTP_STATUS_OTP_CPUMPEN))
> > +                     return -ETIMEDOUT;
> > +     } else {
> > +             lan9662_setbits(OTP_OTP_PWR_DN(otp->base),
> > +                             OTP_OTP_PWR_DN_OTP_PWRDN_N);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int lan9662_otp_execute(struct lan9662_otp *otp)
> > +{
> > +     if (lan9662_otp_wait_flag_clear(OTP_OTP_CMD_GO(otp->base),
> > +                                     OTP_OTP_CMD_GO_OTP_GO))
> > +             return -ETIMEDOUT;
> > +
> > +     if (lan9662_otp_wait_flag_clear(OTP_OTP_STATUS(otp->base),
> > +                                     OTP_OTP_STATUS_OTP_BUSY))
> > +             return -ETIMEDOUT;
> > +
> > +     return 0;
> > +}
> > +
> > +static void lan9662_otp_set_address(struct lan9662_otp *otp, u32 offset)
> > +{
> > +     WARN_ON(offset >= OTP_MEM_SIZE);
> > +
> would we ever hit this condition? looks like unecessary check.

That is not the case. I will remove it.

> 
> 
> 

-- 
/Horatiu
