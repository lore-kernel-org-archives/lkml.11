Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A975C35294
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Apr 2022 21:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380144AbiDDV7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380060AbiDDSvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 14:51:19 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D053137D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 11:49:23 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 12so10978263oix.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 11:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+x8xeE7VdwyEBg9gBJjb/VSkL3ctOrEYGykxx0ig/m0=;
        b=aIIJqQOlgGEaPFjQYKZkBfSoalRDYuXCqe3vleD+YoMT6FyQdOFPNf+S+9sxlwUq54
         NmltyIWDy33kTR0OTRadOhK77QdqSl8Vr+QvqTOBdxzTwwZoyooJtH7PAoM4B6VuHvOb
         mnKMngV7nKSgJ1NYzzG0jE2zETbUAFXGphzJoGcUTTRIAspUa2tNMrIYjM7MWIWIy/8E
         NjJS7bznd7wBf5/40L9ymVkjSitPiflm5WaSfgHVSllrk9/yCcHtgWJ+KTmIMLY7VEhr
         o2TpSk48hwsKaRx3fAQt2RGKCujfvasVxP9JLA++ZfvQi49nDSq+okk9BBSdlu/rffvk
         cO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+x8xeE7VdwyEBg9gBJjb/VSkL3ctOrEYGykxx0ig/m0=;
        b=R3FbIAvaNstONR5LrL0tNQIVWBNxZqtoiGMXiZQZTBUFbUmcfnzLgznNP42LJfDgjX
         jOSGidS+c5GcLjySTf63M5ZAYYpL+C1CzxrqyV8zL3XG+7troMaPPX41KCFix7O+CqIu
         QdCCthreqQW2fPtOUxl5ksK6Y1iiXuA5lH34mUp77vSripFlrM3KbJrSfrz8Nildf07U
         ZfhSx0z4IskLfaH7wo+FHKJFxR48EiRHrQNSFY4y/UA8/Ias6CsoHrGY03CkKqE+/PpZ
         kqSW7j6T6N5BHeFp27959sJFpfgnjJNMAPP5LBv7Fqlj1AgCELKEIXw2b0NX3ClH48cx
         5D3w==
X-Gm-Message-State: AOAM530l5ilR9gOGJH0lLThQ9nsxnVavAJPAq2hHE+s2Y9wgpTUFkYY+
        DBPja6WLZQLqWVDAv9PT9Ao=
X-Google-Smtp-Source: ABdhPJy1vzaNMEa6qR1jv8tDRSZiMxYpeg4RNjKExhY59rCu0Q+CxA5CqAv26vovX2cZDXQXs4yhBg==
X-Received: by 2002:a05:6808:9ae:b0:2d9:a01a:4bf4 with SMTP id e14-20020a05680809ae00b002d9a01a4bf4mr238080oig.283.1649098162576;
        Mon, 04 Apr 2022 11:49:22 -0700 (PDT)
Received: from ?IPV6:2603:8090:2005:39b3::1004? (2603-8090-2005-39b3-0000-0000-0000-1004.res6.spectrum.com. [2603:8090:2005:39b3::1004])
        by smtp.gmail.com with ESMTPSA id m17-20020a0568301e7100b005b256697d7csm4795089otr.72.2022.04.04.11.49.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 11:49:21 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <547963ab-4922-3208-fe63-07e0756890d9@lwfinger.net>
Date:   Mon, 4 Apr 2022 13:49:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] staging: r8188eu: remove unnecessary blank lines
Content-Language: en-US
To:     Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>,
        outreachy@lists.linux.dev
Cc:     phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220404145217.15069-1-eng.alaamohamedsoliman.am@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <20220404145217.15069-1-eng.alaamohamedsoliman.am@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/22 09:52, Alaa Mohamed wrote:
> Reported by checkpatch:
> 
> CHECK: Blank lines aren't necessary before a close brace '}'
> 
> Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
> ---
>   drivers/staging/r8188eu/core/rtw_ap.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
> index 2ff78ed1faab..ac6effbecf6d 100644
> --- a/drivers/staging/r8188eu/core/rtw_ap.c
> +++ b/drivers/staging/r8188eu/core/rtw_ap.c
> @@ -188,7 +188,6 @@ void	expire_timeout_chk(struct adapter *padapter)
>   				spin_lock_bh(&pstapriv->auth_list_lock);
>   			}
>   		}
> -
>   	}
>   	spin_unlock_bh(&pstapriv->auth_list_lock);
>   
> @@ -381,7 +380,6 @@ void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
>   		/* set ra_id, init_rate */
>   		psta->raid = raid;
>   		psta->init_rate = init_rate;
> -
>   	}
>   }
>   
> @@ -455,7 +453,6 @@ void update_bmc_sta(struct adapter *padapter)
>   		spin_lock_bh(&psta->lock);
>   		psta->state = _FW_LINKED;
>   		spin_unlock_bh(&psta->lock);
> -
>   	}
>   }
>   

Acked_by: Larry Finger <Larry.Finger@lwfinger.net>

Thanks,

Larry

