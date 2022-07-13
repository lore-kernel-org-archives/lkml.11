Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40998C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jul 2022 08:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234899AbiGMIaO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jul 2022 04:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiGMIaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:30:10 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BD9675A2;
        Wed, 13 Jul 2022 01:30:09 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id o18so9810499pgu.9;
        Wed, 13 Jul 2022 01:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BWQvjMQ5inhsm0CdHfIF13hOiwKRb2a2r0nx6p9/cQg=;
        b=Et5yLhyVmtQ/HToChewgH/H3j5oS9qpVmFXccRC53PvpTtqWzJlepeEJzcZzv2BGVc
         W2T49G+70jqacCtK2w0nh/xJOEmqp7HeYrfIY9lNay9FCwxJ8MpUIzRkxRHwfPwkY9Zg
         R2TeuWHrJWTBObVaB65Qjq344HIRQ29UFAuX30GzxcJGm44MdxeryYglcgHSup18QwVW
         72JcC02zHvIakm/LTOxVuxLGRaioz+vIrrQPwke1sM+my8mYxZFUUUwWowm2aQpVgWSI
         hLY6lFccqrCGLV6P0Ip6u6uk6BMkrPBuguHDIDUktiRX/C1iUM3xoCWKqKbeaQGDek6T
         m1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BWQvjMQ5inhsm0CdHfIF13hOiwKRb2a2r0nx6p9/cQg=;
        b=6TpXHmpEHt0aDsc8zq+yhErj/+EJgG/d3qhvt2IOo5ZLdDWHweQc1panrpuLzFWAVP
         W7bF9A9W2ZmnubJGWLuTPvC/DjSggwEsrV2rC7Zk/tZ9ZzbITLasFmjraVS4p8ijx6Ei
         CXCkI5oAdZlRBXbKj3LkufphprbuspbJpZWLhxHw/9H+p1jPNXKPPomGj23lNhSBvy0w
         kQ4egLClc68TXMxWoV/XKhM88g8D9IwWa/oAaLEQBDRYY1IvdJn+WFAex0LMoDMYZjpQ
         xVrNxo711BleG0btqfGOniGBKtUfI3bBG4zKJy/bYWSbo2gdF/jJc6zN30Zr5k2GcKZS
         N19Q==
X-Gm-Message-State: AJIora8rPomU2D2lF8flrLac6MfbVCMiLlGZWFINhqT18JLXabr5XDCf
        w2Ybmnv6sykONocemIoTu3g=
X-Google-Smtp-Source: AGRyM1u6z3sl7mLQVq3cDI2EW77OeGWimtpFTZKrFrJbylx2lFL2WwlW7jI246VrujgqZCaxDQY0Dw==
X-Received: by 2002:a63:f742:0:b0:415:cb55:7ceb with SMTP id f2-20020a63f742000000b00415cb557cebmr2107513pgk.134.1657701009430;
        Wed, 13 Jul 2022 01:30:09 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-1.three.co.id. [180.214.232.1])
        by smtp.gmail.com with ESMTPSA id c204-20020a624ed5000000b00528c4c770c5sm8168545pfb.77.2022.07.13.01.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 01:30:08 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 9F7D610396A; Wed, 13 Jul 2022 15:30:03 +0700 (WIB)
Date:   Wed, 13 Jul 2022 15:30:02 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com
Subject: Re: [PATCH 5.18 00/61] 5.18.12-rc1 review
Message-ID: <Ys6CilcxvmHAohV1@debian.me>
References: <20220712183236.931648980@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220712183236.931648980@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 08:38:57PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.18.12 release.
> There are 61 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 

Successfully cross-compiled for arm64 (bcm2711_defconfig, GCC 10.2.0)
and powerpc (ps3_defconfig, GCC 12.1.0).

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara
