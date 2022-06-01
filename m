Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06AFC433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jun 2022 07:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350232AbiFAHOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jun 2022 03:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350298AbiFAHOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 03:14:40 -0400
X-Greylist: delayed 593 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Jun 2022 00:14:22 PDT
Received: from postler.einfach.org (postler.einfach.org [IPv6:2a01:4f8:151:8388::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07087996B6
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 00:14:21 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by postler.einfach.org (Postfix) with ESMTP id DA471364FEFB;
        Wed,  1 Jun 2022 07:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=einfach.org; s=mail;
        t=1654067065; bh=8YCkdC30YH1NQT1nteqzBL0uHfjNN9j3pN+keJRnp5M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=T/vUQp3FYLmSw+MK35Jbb5ePJGNvgq92AhaXsgcj5qpymTW/N3bNNXpfEnW6gvYvP
         NFKwafLb4PN3VkDiPwSXx/a36naci8YhFey3cOW8TiepT0ERoUnDpOTu6nJ0XGeVtU
         XKOSD2TPBNPQgfop1gLyxq94eJbaiNlaiZodQ/RE=
X-Virus-Scanned: amavisd-new at postler.einfach.org
Received: from postler.einfach.org ([127.0.0.1])
        by localhost (postler.einfach.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id y_pkQy3yqosu; Wed,  1 Jun 2022 07:04:25 +0000 (UTC)
Received: from [IPV6:2001:8a0:eece:d600:d02:7d0e:76a1:908b] (unknown [IPv6:2001:8a0:eece:d600:d02:7d0e:76a1:908b])
        by postler.einfach.org (Postfix) with ESMTPSA id 15D3C3616726;
        Wed,  1 Jun 2022 07:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=einfach.org; s=mail;
        t=1654067065; bh=8YCkdC30YH1NQT1nteqzBL0uHfjNN9j3pN+keJRnp5M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=T/vUQp3FYLmSw+MK35Jbb5ePJGNvgq92AhaXsgcj5qpymTW/N3bNNXpfEnW6gvYvP
         NFKwafLb4PN3VkDiPwSXx/a36naci8YhFey3cOW8TiepT0ERoUnDpOTu6nJ0XGeVtU
         XKOSD2TPBNPQgfop1gLyxq94eJbaiNlaiZodQ/RE=
Message-ID: <e3ba1b78-5047-3bb3-e1af-988c718c075b@einfach.org>
Date:   Wed, 1 Jun 2022 08:04:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] average: Clarify the restrictions
Content-Language: en-US
To:     Jui-Tse Huang <juitse.huang@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Ching-Chun Huang <jserv@ccns.ncku.edu.tw>
References: <20220601065746.18426-1-juitse.huang@gmail.com>
From:   Bruno Randolf <br1@einfach.org>
In-Reply-To: <20220601065746.18426-1-juitse.huang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2022 07:57, Jui-Tse Huang wrote:
> There is several restrictions in the EWMA helper macro that the
> developers should take care of, but the comment does not mentioned yet,
> thus, this patch clarify the restrictions.
> 
> Signed-off-by: Jui-Tse Huang <juitse.huang@gmail.com>
> ---
>   include/linux/average.h | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/average.h b/include/linux/average.h
> index a1a8f09631ce..1618f6519c3d 100644
> --- a/include/linux/average.h
> +++ b/include/linux/average.h
> @@ -13,6 +13,10 @@
>    * precision and fall-off coefficient determined at compile-time
>    * and built into the generated helper funtions.
>    *
> + * This implementation supports upto 30 bits of precition, and for

spelling: up to ... precision

> + * usage concern, only the api of fetching non-fractional part is
> + * provided for now.

spelling: "API for"

wording: remove "and for usage concern", just ", and only the API for" 
would be enough.

Thank you,
bruno
