Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8B0C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Feb 2022 05:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbiBHFdh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Feb 2022 00:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbiBHFUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 00:20:18 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF811C0401DC;
        Mon,  7 Feb 2022 21:20:16 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id e6so16916645pfc.7;
        Mon, 07 Feb 2022 21:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=ZMzyOA5LAs9QBtjWwJ8XKKlrb5J3zKHcDX+OTPYW99A=;
        b=HWXLFjlW7P1qAc0DN5m7D8fICX4t7Y48xTyFDGVKktNAaVKRt8CvAuxqWXwUcYZayv
         bnnj409Ku+sDmpcfF+1wRuvnG5ra0PsZPCvGXkTjMFiL0GEsjTC3jfda7nKjjKganglP
         9DhMDx9AlVOyG1k+VlHkuYSzr+ZoEGKpm9/PW8wxjJ6EQgTnqKdnzPBD2wuvz5CZgsS+
         23v2GB6PrO/PxZHaF3MiU71RUYGxjQJA6bSBmZSXzirDOn0m7diX70DvrRYTf5Jv+5GU
         2+8TO1BhKQKrI76ZqA0h2c3iTinDKiDBSXoqS7+SEdMIQsHXKCrdHTMUb2noAkz+Bp9X
         HEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=ZMzyOA5LAs9QBtjWwJ8XKKlrb5J3zKHcDX+OTPYW99A=;
        b=ZNlDtqj8vy3EPCnLranL5D7OgSGVaxVsjd3GTlvtajfni6LubsUFcyIRzG3hQPzsMy
         zFem+8dzKiB0ML60EUNYUPBm0xyzOmSCfnAOz4xDT+umZ6k2o2kasMNjjeoa3vPoYo8b
         d1raSizeHLMjhzjP1Ex/1MBlfsL6lXDHkiYAeLSubpuRh0SzKRt9bOUn41d9AbyhSIRZ
         J/shaq1dpsx1+V87dWwEU7eDSzLLJsW61IlUpLHpZRXjYKUdhrJuBKSaYRInYyXUDVHG
         hg25o8dm8hDSRJsa68z0/+Uj32LbeVTcl3pPkt0REYUpHrKH7+mCswFdog+OztUJuZh+
         YSdQ==
X-Gm-Message-State: AOAM532VS+LseOFX09M6O3zwbIHilWddwUuZmZC+zWUh8HmNJ+E8A3vu
        0ph37UJQs63ela7vIcTZM9A=
X-Google-Smtp-Source: ABdhPJyeI7iNgPA7uQpNmExmMfX8EIICD67Xr83rhNxp5evM53CXvnHv461Uu7hCBf2BiC+H9iUMCQ==
X-Received: by 2002:a63:4003:: with SMTP id n3mr1528061pga.279.1644297616263;
        Mon, 07 Feb 2022 21:20:16 -0800 (PST)
Received: from [192.168.43.80] (subs32-116-206-28-20.three.co.id. [116.206.28.20])
        by smtp.gmail.com with ESMTPSA id om18sm1128306pjb.39.2022.02.07.21.20.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 21:20:15 -0800 (PST)
Message-ID: <168761dc-af22-8093-b308-50d3d1fcdc55@gmail.com>
Date:   Tue, 8 Feb 2022 12:20:10 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH 5.15 000/111] 5.15.22-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com
References: <20220207133903.595766086@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20220207133903.595766086@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/22 21.04, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.22 release.
> There are 111 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 

Successfully cross-compiled for arm64 (bcm2711_defconfig, gcc 10.2.0) and
powerpc (ps3_defconfig).

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara
