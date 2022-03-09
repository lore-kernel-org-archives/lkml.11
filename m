Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01031C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Mar 2022 12:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbiCIMZl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Mar 2022 07:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbiCIMZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 07:25:39 -0500
Received: from smtp89.iad3b.emailsrvr.com (smtp89.iad3b.emailsrvr.com [146.20.161.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093E913CEEC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 04:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1646828678;
        bh=bMk6SH4+xE/VWMemKZrJ+383q5mqM+mCCH2TsKLVzfo=;
        h=Date:Subject:To:From:From;
        b=i8DbzrQ2jlHoW50lLNhe5DSZ8UKplgNDyXL6Hg9FCqly+Sqy32KnnPOZnssgevTUN
         BKHrKvdtBe+8gbuu/UbhfstX7SRP1zLqVBs+uKtD1HkkgoTtEdW4X0cRuQvStXFrtI
         s02mb9t7Q94yp8DJ2raPq/Ddodq/sUrnBiD2OolM=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp4.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 3A8C120114;
        Wed,  9 Mar 2022 07:24:38 -0500 (EST)
Message-ID: <d7ce73c6-8c0b-f447-835f-9e2e6f402f7c@mev.co.uk>
Date:   Wed, 9 Mar 2022 12:24:37 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 10/10] Constify comedi_lrange struct pointers
Content-Language: en-GB
To:     Hatim Muhammed <hatimmohammed369@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     greg@kroah.com, hsweeten@visionengravers.com
References: <20220309092003.13928-1-hatimmohammed369@gmail.com>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <20220309092003.13928-1-hatimmohammed369@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: 6a10ea7a-6443-4c6c-a7d0-9923700dadf8-1-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2022 09:20, Hatim Muhammed wrote:
> From: Hatim Muhammed <hatimmohammed369@gmail.com>
> 
> Signed-off-by: Hatim Muhammed <hatimmohammed369@gmail.com>
> ---
>   drivers/comedi/drivers/jr3_pci.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/comedi/drivers/jr3_pci.c b/drivers/comedi/drivers/jr3_pci.c
> index 951c23fa0369..f2a750a9112c 100644
> --- a/drivers/comedi/drivers/jr3_pci.c
> +++ b/drivers/comedi/drivers/jr3_pci.c
> @@ -90,8 +90,8 @@ struct jr3_pci_dev_private {
>   };
>   
>   union jr3_pci_single_range {
> -	struct comedi_lrange l;
> -	char _reserved[offsetof(struct comedi_lrange, range[1])];
> +	const struct comedi_lrange l;
> +	char _reserved[offsetof(const struct comedi_lrange, range[1])];
>   };
>   
>   enum jr3_pci_poll_state {

NAK. That really should not be const.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-
