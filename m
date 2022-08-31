Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB309ECAAD1
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Aug 2022 13:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbiHaNYq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Aug 2022 09:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbiHaNYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 09:24:40 -0400
Received: from smtp87.ord1c.emailsrvr.com (smtp87.ord1c.emailsrvr.com [108.166.43.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E407ACA00
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 06:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1661952279;
        bh=mVD6t3e+NRFtpb3PbBmCKxFlAeI7rEwnU0/iox6aooo=;
        h=Date:Subject:To:From:From;
        b=dwPiZccYkKFynCsrpS9+oXumnHCDP2Nr27pb5afJBG9m4n2DRSVOZMLze3tw7Rodl
         AkIRl6Rs68fnhXOSzu7GOq1kEMWrJL67FGgq4waFz999AuGCzmptMBkabu/iczthvF
         ZoZWywdYZ2fr64HLb1585FT9qchkxbKU1MLPSyWU=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp3.relay.ord1c.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 92D15A0173;
        Wed, 31 Aug 2022 09:24:38 -0400 (EDT)
Message-ID: <9095e6df-d261-f1be-af35-187d9b632658@mev.co.uk>
Date:   Wed, 31 Aug 2022 14:24:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3] comedi: convert sysfs snprintf to sysfs_emit
Content-Language: en-GB
To:     Xuezhi Zhang <zhangxuezhi3@gmail.com>,
        hsweeten@visionengravers.com, gregkh@linuxfoundation.org,
        zhangxuezhi1@coolpad.com
Cc:     linux-kernel@vger.kernel.org
References: <20220831130916.239870-1-zhangxuezhi3@gmail.com>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <20220831130916.239870-1-zhangxuezhi3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: f749f8e2-efb6-4c25-9b3d-8fd6c84412b4-1-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/08/2022 14:09, Xuezhi Zhang wrote:
> From: Xuezhi Zhang <zhangxuezhi1@coolpad.com>
> 
> Fix up all sysfs show entries to use sysfs_emit
> 
> Signed-off-by: Xuezhi Zhang <zhangxuezhi1@coolpad.com>
> ---
> v2: use a proper name for the Signed-off-by line.
> v3: fix From line and Subject line.
> ---
>   drivers/comedi/comedi_fops.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
> index 55a0cae04b8d..e2114bcf815a 100644
> --- a/drivers/comedi/comedi_fops.c
> +++ b/drivers/comedi/comedi_fops.c
> @@ -396,7 +396,7 @@ static ssize_t max_read_buffer_kb_show(struct device *csdev,
>   	mutex_unlock(&dev->mutex);
>   
>   	comedi_dev_put(dev);
> -	return snprintf(buf, PAGE_SIZE, "%u\n", size);
> +	return sysfs_emit(buf, "%u\n", size);
>   }
>   
>   static ssize_t max_read_buffer_kb_store(struct device *csdev,
> @@ -452,7 +452,7 @@ static ssize_t read_buffer_kb_show(struct device *csdev,
>   	mutex_unlock(&dev->mutex);
>   
>   	comedi_dev_put(dev);
> -	return snprintf(buf, PAGE_SIZE, "%u\n", size);
> +	return sysfs_emit(buf, "%u\n", size);
>   }
>   
>   static ssize_t read_buffer_kb_store(struct device *csdev,
> @@ -509,7 +509,7 @@ static ssize_t max_write_buffer_kb_show(struct device *csdev,
>   	mutex_unlock(&dev->mutex);
>   
>   	comedi_dev_put(dev);
> -	return snprintf(buf, PAGE_SIZE, "%u\n", size);
> +	return sysfs_emit(buf, "%u\n", size);
>   }
>   
>   static ssize_t max_write_buffer_kb_store(struct device *csdev,
> @@ -565,7 +565,7 @@ static ssize_t write_buffer_kb_show(struct device *csdev,
>   	mutex_unlock(&dev->mutex);
>   
>   	comedi_dev_put(dev);
> -	return snprintf(buf, PAGE_SIZE, "%u\n", size);
> +	return sysfs_emit(buf, "%u\n", size);
>   }
>   
>   static ssize_t write_buffer_kb_store(struct device *csdev,

Looks good, thanks!

Reviewed-by: Ian Abbott <abbotti@mev.co.uk>

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-
