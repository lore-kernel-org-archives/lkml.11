Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D77ECAAA3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Aug 2022 12:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245597AbiHZMLe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Aug 2022 08:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245546AbiHZML3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 08:11:29 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F934DD753;
        Fri, 26 Aug 2022 05:11:29 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id r15-20020a17090a1bcf00b001fabf42a11cso1437023pjr.3;
        Fri, 26 Aug 2022 05:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=PotJ1wRmqkbv3voX6k4qeuA7obENHsV2m/UgBbrlOOI=;
        b=Db340hCV4Fq8RLFaxcWdmacj0FyV5VSYpqXRmmpyxPjvvKSj9w9uEhYtoPjIQ7BI2X
         iaPtydFptX3IrPlBjVj5jNAOg3LPeLSt4uFuC66jKoeL37A644lShCu0iNzLRm0IMeGN
         rl8fAwGLbTiUdgi5D7wuHdRdLJ6bkjGdSD7bpQoTUpWaaPRt6M1ORDH5nqgf5E+L+3hD
         2W4980+/0o1A+lkERMnTIE7ii8HgUBNTOwLBpxSX3rN1i9BVVun0G9rCh/tkym+cvhrf
         3/y5cWO5wX1gXyNajyOX2V5kMbpQJxKKTTPfQmeT0RyRT+xmZbxPE/dXiwtfPpRaYZAa
         TkyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=PotJ1wRmqkbv3voX6k4qeuA7obENHsV2m/UgBbrlOOI=;
        b=xw+5o5YMXvwLkeI7CdNlwX5wkzoJx5u6cJXbtux879JBfrkGSmhjxiKY+S0p6KlbqF
         Ymwrh+p8M2fMivUKSv4r0HGtuA5OznOGh/3GDmaXFaCqOKnN5yQ+iZMbNsk44UoDPSlR
         W8CC6ILVwIjy5zF3TafW397R+Y9tXdPIMQAGjxfa5R/pSe9nNaOiSEXpohsGpmaP6DHj
         lzfwzkCymTWpVeaWlJnfeb+TqJf9/J5GEOiX1+htTsHDEn8QkG1iLylsMwAjVR7nYBa5
         nRyrRdWfJy295A3yc7kVLcKEBp78GScCLFwIqULW/njtrz2ZxvVu79TX3zb3llvbDrvl
         3Yqw==
X-Gm-Message-State: ACgBeo0idrzJLVtBtL87p52sI7o4/bUJhuLfMR5YtqNHJ/HaZ+VR5Jm+
        yaqq8i9eU83JBvj7x+39NUQ=
X-Google-Smtp-Source: AA6agR61Fy97WeEjRcYwmgw2ZGGc63DLAP1ZQwZfLZx/2DyREl0AeNYmXWxW8htKkhU3H5bYlJMKSw==
X-Received: by 2002:a17:90b:388c:b0:1fb:6738:6e50 with SMTP id mu12-20020a17090b388c00b001fb67386e50mr4005131pjb.231.1661515888580;
        Fri, 26 Aug 2022 05:11:28 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r10-20020aa79eca000000b0052d981e7842sm1545874pfq.208.2022.08.26.05.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 05:11:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 26 Aug 2022 05:11:26 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     cgel.zte@gmail.com
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        xupanda <xu.panda@zte.com.cn>, Zeal Robot <zeal@zte.com.cn>
Subject: Re: [PATCH linux-next v2] usb: typec: tcpm: tcpci: Remove the
 unneeded result variable
Message-ID: <20220826120548.GA2897306@roeck-us.net>
References: <20220826091731.254966-1-xu.panda@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826091731.254966-1-xu.panda@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 09:17:32AM +0000, cgel.zte@gmail.com wrote:
> From: xupanda <xu.panda@zte.com.cn>
> 
> Return the value regmap_update_bits() directly instead of
> storing it in another redundant variable.
> 
> Reported-by: Zeal Robot <zeal@zte.com.cn>
> Signed-off-by: xupanda <xu.panda@zte.com.cn>

This needs to be a real (full) name.

> 
> ---
> change for v2
>  - remove those irrelevant sentences 
> ---
> 
>  drivers/usb/typec/tcpm/tcpci.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> index b2bfcebe218f..29047da826a9 100644
> --- a/drivers/usb/typec/tcpm/tcpci.c
> +++ b/drivers/usb/typec/tcpm/tcpci.c
> @@ -328,11 +328,9 @@ static int tcpci_set_vconn(struct tcpc_dev *tcpc, bool enable)
>  static int tcpci_enable_auto_vbus_discharge(struct tcpc_dev *dev, bool enable)
>  {
>  	struct tcpci *tcpci = tcpc_to_tcpci(dev);
> -	int ret;
>  
> -	ret = regmap_update_bits(tcpci->regmap, TCPC_POWER_CTRL, TCPC_POWER_CTRL_AUTO_DISCHARGE,
> +	return regmap_update_bits(tcpci->regmap, TCPC_POWER_CTRL, TCPC_POWER_CTRL_AUTO_DISCHARGE,
>  				 enable ? TCPC_POWER_CTRL_AUTO_DISCHARGE : 0);

Continuation line alignment still needs to be adjusted.

Both were aready mentioned in feedback to v1 of the patch.

Guenter
