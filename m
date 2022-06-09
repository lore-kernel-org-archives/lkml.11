Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6D6C433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jun 2022 08:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242660AbiFII7i (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jun 2022 04:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240066AbiFII71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:59:27 -0400
Received: from smtp64.iad3b.emailsrvr.com (smtp64.iad3b.emailsrvr.com [146.20.161.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954284838C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 01:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1654765158;
        bh=In6RdT6x1r/mPtfSfwq7LpTZ4jynKueaqKBZ7l1DSOQ=;
        h=Date:Subject:To:From:From;
        b=WRisZWnAWmy5VZbG4UaMxAnt/sDYJ+sY34w/21kRn6uMYu+LQpcQxR9+AaLEXUiuP
         dxnQgzXUjKe437B1xLsdo04TojxqfJUYnmdmZ8laXslwx9wOF99ukjpwCnWyscs8l3
         XgTP80xIAcStxOKxMfRlnuVZmpgzI7pt5ZK1dppY=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp17.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id D8849A00A6;
        Thu,  9 Jun 2022 04:59:17 -0400 (EDT)
Message-ID: <04fe1a93-29a6-3c22-1046-00add4755055@mev.co.uk>
Date:   Thu, 9 Jun 2022 09:59:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] Staging: comedi: comedi_fops: fixed a spacing coding
 style issue
Content-Language: en-GB
To:     Agam Kohli <agamkohli9@gmail.com>, gregkh@linuxfoundation.org
Cc:     hsweeten@visionengravers.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20220609045334.93266-1-agamkohli9@gmail.com>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <20220609045334.93266-1-agamkohli9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: d18b51b2-f877-4e58-8e48-03c7348855e5-1-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2022 05:53, Agam Kohli wrote:
> Fixed a coding style issue.
> 
> Signed-off-by: Agam Kohli <agamkohli9@gmail.com>
> ---
>   drivers/staging/comedi/comedi_fops.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/staging/comedi/comedi_fops.c b/drivers/staging/comedi/comedi_fops.c
> index e85a99b68f31..3f70e5dfac39 100644
> --- a/drivers/staging/comedi/comedi_fops.c
> +++ b/drivers/staging/comedi/comedi_fops.c

comedi moved out of "drivers/staging" in the 5.13 kernel.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-
