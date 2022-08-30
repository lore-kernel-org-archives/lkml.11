Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BF9ECAAA1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Aug 2022 10:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiH3K6E (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Aug 2022 06:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiH3K56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:57:58 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A99A405E;
        Tue, 30 Aug 2022 03:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661857075; x=1693393075;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DCdm7zO12JjMTqB/LiqCExVRxENy5N3vIqGs/oWeM0s=;
  b=hBHemhB9maKn67gECoKgRseGZ9A8v0QIx0QQyYW8C2eSgiyyypx0FfTa
   vHznQicWFh/EpzFLJcJyKRWj6vw8R24WMbU10P/ai4WKa9puBF1zK3DsE
   u0DNaAOtUfjw1Pqysbdlz4AnZ64HCJS/4R30dCVdvvVryv2aVuXkolH4N
   IjVdqaKW/7JYMjRK3zYKcnEm6Bly/M6TezbmQW6GDemqzpJ7YepjyyL3C
   Br1Gb+mDRgKhG+CmSVzttsCPOqlGyw+e5qQcX6QuKzTyP1cBdVOtpexak
   bydUgeVQZNalAagvPqUtaSaQtGwzCLfvArO1gB+YPwwmnFuuRluHGucDl
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="293888381"
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="293888381"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 03:57:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="753987563"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 30 Aug 2022 03:57:50 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 30 Aug 2022 13:57:49 +0300
Date:   Tue, 30 Aug 2022 13:57:49 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
Subject: Re: [PATCH v1 3/4] usb: typec: tcpci_maxim: Export helper function
 for register reads
Message-ID: <Yw3tLf6lcmtU1+t/@kuha.fi.intel.com>
References: <20220826084001.3341215-1-badhri@google.com>
 <20220826084001.3341215-3-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826084001.3341215-3-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Badhri,

On Fri, Aug 26, 2022 at 01:40:00AM -0700, Badhri Jagan Sridharan wrote:
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

No commit message? I guess you want to do this because you want to
split the driver into several files. Please put that into your commit
message.

> ---
>  drivers/usb/typec/tcpm/tcpci_maxim.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.c b/drivers/usb/typec/tcpm/tcpci_maxim.c
> index 4b6705f3d7b7..af3a7ecab23b 100644
> --- a/drivers/usb/typec/tcpm/tcpci_maxim.c
> +++ b/drivers/usb/typec/tcpm/tcpci_maxim.c
> @@ -68,25 +68,29 @@ static struct max_tcpci_chip *tdata_to_max_tcpci(struct tcpci_data *tdata)
>  	return container_of(tdata, struct max_tcpci_chip, data);
>  }
>  
> -static int max_tcpci_read16(struct max_tcpci_chip *chip, unsigned int reg, u16 *val)
> +inline int max_tcpci_read16(struct max_tcpci_chip *chip, unsigned int reg, u16 *val)
>  {
>  	return regmap_raw_read(chip->data.regmap, reg, val, sizeof(u16));
>  }
> +EXPORT_SYMBOL_GPL(max_tcpci_read16);

Hold on! You don't need to export these under any circumstance.

If you want to make these inline function, move them to a header.
Otherwise just make them non-static.

Either way, don't export them.

> -static int max_tcpci_write16(struct max_tcpci_chip *chip, unsigned int reg, u16 val)
> +inline int max_tcpci_write16(struct max_tcpci_chip *chip, unsigned int reg, u16 val)
>  {
>  	return regmap_raw_write(chip->data.regmap, reg, &val, sizeof(u16));
>  }
> +EXPORT_SYMBOL_GPL(max_tcpci_write16);
>  
> -static int max_tcpci_read8(struct max_tcpci_chip *chip, unsigned int reg, u8 *val)
> +inline int max_tcpci_read8(struct max_tcpci_chip *chip, unsigned int reg, u8 *val)
>  {
>  	return regmap_raw_read(chip->data.regmap, reg, val, sizeof(u8));
>  }
> +EXPORT_SYMBOL_GPL(max_tcpci_read8);
>  
> -static int max_tcpci_write8(struct max_tcpci_chip *chip, unsigned int reg, u8 val)
> +inline int max_tcpci_write8(struct max_tcpci_chip *chip, unsigned int reg, u8 val)
>  {
>  	return regmap_raw_write(chip->data.regmap, reg, &val, sizeof(u8));
>  }
> +EXPORT_SYMBOL_GPL(max_tcpci_write8);
>  
>  static void max_tcpci_init_regs(struct max_tcpci_chip *chip)
>  {
> -- 
> 2.37.2.672.g94769d06f0-goog

-- 
heikki
