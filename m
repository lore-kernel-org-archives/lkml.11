Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D880CCA480
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jun 2022 17:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236047AbiF3RGm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jun 2022 13:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236030AbiF3RGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 13:06:41 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8333B3E5FD
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 10:06:40 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id b12-20020a17090a6acc00b001ec2b181c98so3767375pjm.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 10:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eAr7PQsxKeew00/CVr7ZzHucmGcjpALBBy+n+XFui6I=;
        b=Fwuwe3ZO30tghfWbLzVhLTW/P804T2Iz/JWwmhIB0XzUV4tCO5Uy0L2KikEz2oooFz
         hOR6Xk/OVmzbBBFFm7kfk/KAB/7BxuheUHQtleYNMVMkEpp33O5kjAbL3t9lGN9IfIGN
         ctq1Ws8as/OXK1bwSua1Y6wC7GX1cUBXst0QkpET2rHi221GVeFqtFK3LtiVfDlUy12b
         rVeoI9PeueFXnVBx3U5ip/zqlKSuY4kHNz4z/xLE1bOA7VNo1RPAS02cbgEhVTeRCXoW
         wV1lft9xJZdMU9U+QbkE1JJaOydnZelnNI6qwx19uIbPyhWhP9XsUgCKEfvxEMsGpQDj
         gxeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eAr7PQsxKeew00/CVr7ZzHucmGcjpALBBy+n+XFui6I=;
        b=5KiKIWQS7/tQS+knHf5QugiZ2Bj2EdfIQ/5Wnse4Pb0ZrtdLhsAzlDzlzOG/bKkXpn
         pRKV0aD7Y9Ok52OudcFi3718clbCCEB1RV+QZ2K8CdU7d77cGX0YDY0PkgaH9Vm7JIoT
         CtYjP9nmNX39ijlcDY9dJgoYaFGn//+wnigp5CfG+gekOX+2wyY3280PfAEGft4AWr4M
         qsRBlepYwgewzxC3e0OuQXv2LX7g7B0p3Xi2CWva73WXalNrJe39haf35ujXBM6gAdLe
         qT/xXS/H3HYUhLgyi15NJC5bpPFg7zfUtvbhkym0j3URrXuNmOmfIYno7su8coKxD9fV
         YK4w==
X-Gm-Message-State: AJIora9vWkhWbw4bxcQzYgG5iaztSzH1PvDNT6i9SHUysw4pDAicWU6i
        eOX9gqsZJlfi0Bh87aVftiurWA==
X-Google-Smtp-Source: AGRyM1tQlkoaEbHG6+vV4lZEf6QKE6dhZv4RO/68eWlgyxt5ZkZDUlagQJLqtw41qfD37FBmZiz7QA==
X-Received: by 2002:a17:902:e381:b0:16a:1b5d:5438 with SMTP id g1-20020a170902e38100b0016a1b5d5438mr16387906ple.147.1656608799905;
        Thu, 30 Jun 2022 10:06:39 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id f24-20020a63f118000000b0040caab35e5bsm7580699pgi.89.2022.06.30.10.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 10:06:38 -0700 (PDT)
Date:   Thu, 30 Jun 2022 11:06:36 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-doc@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh@kernel.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH next] Documentation: coresight: escape coresight bindings
 file wildcard
Message-ID: <20220630170636.GA2090408@p14s>
References: <20220630101317.102680-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630101317.102680-1-bagasdotme@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 05:13:17PM +0700, Bagas Sanjaya wrote:
> Stephen Rothwell reported htmldocs warning:
> 
> Documentation/trace/coresight/coresight.rst:133: WARNING: Inline emphasis start-string without end-string.
> 
> The warning above is due to unescaped wildcard asterisk (*) on CoreSight
> devicetree binding filename, which confuses Sphinx as emphasis instead.
> 
> Escape the wildcard to fix the warning.
> 
> Link: https://lore.kernel.org/linux-next/20220630173801.41bf22a2@canb.auug.org.au/
> Fixes: 3c15fddf312120 ("dt-bindings: arm: Convert CoreSight bindings to DT schema")
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Rob Herring <robh@kernel.org>
> Cc: coresight@lists.linaro.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-next@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/trace/coresight/coresight.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Applied.

Thanks,
Mathieu

> diff --git a/Documentation/trace/coresight/coresight.rst b/Documentation/trace/coresight/coresight.rst
> index 529b7c80e6f353..1644a0244ad10a 100644
> --- a/Documentation/trace/coresight/coresight.rst
> +++ b/Documentation/trace/coresight/coresight.rst
> @@ -130,7 +130,7 @@ Misc:
>  Device Tree Bindings
>  --------------------
>  
> -See Documentation/devicetree/bindings/arm/arm,coresight-*.yaml for details.
> +See Documentation/devicetree/bindings/arm/arm,coresight-\*.yaml for details.
>  
>  As of this writing drivers for ITM, STMs and CTIs are not provided but are
>  expected to be added as the solution matures.
> 
> base-commit: 6cc11d2a1759275b856e464265823d94aabd5eaf
> -- 
> An old man doll... just what I always wanted! - Clara
> 
