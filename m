Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280DAC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 16:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbiDNQCI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 12:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359753AbiDNPrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:47:17 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB11FF61CB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:32:37 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id z8so5785437oix.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dZuoh37v+Aj6sqcMi06F2S04MGr5lZnuPaxiehoSWJs=;
        b=BPrwFp10xhFZyfE3N65blMPhWgs1sPmtNBlG/TCafoQI2KPiIuGwSlKZ/GA/tLOKt2
         ssjDXVuaMMigRu352gZA0pvUFXMw4qIhi9F2kVfBEsqhyWoLO+vHs16hZSkbXIB0Eleb
         Ky8MwHcCtsbbaoEFgK6S4KXSsoU4J+nAWRg8sIrmxexLAFSyiyTpmbPYBCwL9B5Wz3YJ
         bJZAKLRuYQvxean4yeUnPli+jXV5zzEGdLx/bMNWGAtX+f/vWWyzxCLHHebkGiYYpab2
         wmjmqonjz8PIOm7VfZQfclUmFbnHPDANwpHb/tLCfTZm1UG673BnZhvx7V8VL6T95liY
         5wrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dZuoh37v+Aj6sqcMi06F2S04MGr5lZnuPaxiehoSWJs=;
        b=fASpJwiXDDL8o0OvrB6HYXpKR91OtOTzxLLyN5vGWcozrpTxMqGKGLOFwSWjWfTO9Y
         w/Awu08N6ql/CPPfeKj33dM/7hT2ARZ/YddWMvvrIIDHCHy4dVO47tBfv4jg0yanRRKC
         QquAdi+niWeWRaHur30/6w/sxV/E0YJg6mixThRElJIOHRH9C5zj2DwBfcKK9BOXbCWR
         2mi366xKzAWRGllu5iiYoOAuO2fTk/7/yzCexcB8y2liLjW/UI5RQuVsmZ4JvxCShlbe
         ofnaGd5L/zPRO9WsYGOHgX+17/EKVa7zvT9rQrx+NtRiOPrnO880J6BmktY65dmm/BAw
         aRUA==
X-Gm-Message-State: AOAM530Bkq6H0NQ6D+8mbZ8IeV/wPulaSLGyg9Jg+kxoaNIP/vSx72+P
        8B6cT0mcUunznW2JdaaSHQw=
X-Google-Smtp-Source: ABdhPJw5rJYiOPYo0P5iabZTEkaoF9juWNaKPcLz9NEA4zgtkNreisfMuVnRoOSWXmp+g/Bw2rxjGg==
X-Received: by 2002:a05:6808:f8f:b0:2f9:76b9:421f with SMTP id o15-20020a0568080f8f00b002f976b9421fmr1895829oiw.281.1649950357262;
        Thu, 14 Apr 2022 08:32:37 -0700 (PDT)
Received: from ?IPV6:2603:8090:2005:39b3::100e? (2603-8090-2005-39b3-0000-0000-0000-100e.res6.spectrum.com. [2603:8090:2005:39b3::100e])
        by smtp.gmail.com with ESMTPSA id b18-20020a056830105200b005e9899ae22dsm121020otp.52.2022.04.14.08.32.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 08:32:36 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <efbd9524-efba-c00b-e191-3e603445e9f4@lwfinger.net>
Date:   Thu, 14 Apr 2022 10:32:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/7] staging: r8188eu: fix struct rt_firmware_hdr
Content-Language: en-US
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20220414083853.3422-1-straube.linux@gmail.com>
 <20220414083853.3422-2-straube.linux@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <20220414083853.3422-2-straube.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/22 03:38, Michael Straube wrote:
> The second issue is that the u16 and u32 fields sould be __le16 and
> __le32.
> 
> Change the field Rsvd1 to u8 and the u16, u32 fileds to __le16, __le32.

There is a typo here.

Note that the various RsvdN fields are just reserving space and will never be 
referenced, thus it does not matter if they are u32 or __le32. It is OK to 
change them, but it is not wrong to leave them the way they are.

Larry

