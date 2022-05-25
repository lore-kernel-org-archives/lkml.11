Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34196C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 May 2022 13:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236650AbiEYNiq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 May 2022 09:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiEYNin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:38:43 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE34F1837A
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 06:38:41 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id m20so41742211ejj.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 06:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jw5KG+dnEClS1TN7YYmDKYqF5G50ipPJ1bBh+wQLV98=;
        b=jqJlUvzp5H/I94PPZ8sn8LXDvvuUIsJhYQuyr/RnyJ4R/D7s/Y7FRHW3aJJFYMkR5T
         lHFLBk7KZb4WWE5tH+Mzi8I46oilLQUrGaFC7lqmzzLHnjq2fcZAFJuBMKKAWNAZRYX/
         8CZNZftTTa48ueI4kj9FyvMdSpJ7h3OlXd7dQsH8lEUpOQXPJJjOeNRb64fnsu/2Mti5
         NzN91r/vcPK9Qq7JU7HLT0yWI9Jf7CuUcxpYEGwjDoQbUPHMVENpx4rWRLRXij18k5TF
         flyRr405EbqnT4M/49sZszLCB7u3b/Oi9kyoYzBfg9CzKZvmQ1WR2iOYlo4lPTj2TooQ
         sM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=jw5KG+dnEClS1TN7YYmDKYqF5G50ipPJ1bBh+wQLV98=;
        b=s2q69fupsIiIbCHGljAVsI+B0IvqAS+M9IaGWaOEoEtKBn/S7cPwOba1lPX2jELOE1
         /DmzVSMxmB5jfhjBEhwkAzCc8TYufxrIWJ6JXwFQIGYJ9wIu9ZNmhF3snlVLrVpzK1HF
         jpFeg5Wu1hPV/Sc5k2aS8qoYs/Fy75Y8g0tRp0wY+HObdE+jvkMoeq0RZps4E1kxCf+6
         aZnRi4ciQIw6HsmLwge73k/DOqtEo8z87yOGQ22Q217rPEKjS8k55AMUT2SZcBb3CWE9
         wzPRxJqr0PcphRSNByItyG7Rq464PX+iZhm6VkGgrEm8p5ykqPyCjeuxoiIkKHCRaalP
         C7RQ==
X-Gm-Message-State: AOAM532xVY3HZi1aA8pJe/1cbTdVNoARZpI+l1vhDQmtdNc8ZJ3XuuOv
        FMe3sIDq15hDuBcfXw2eVx4=
X-Google-Smtp-Source: ABdhPJwbZ4H/KKnpf2NVDQLhnNfqYUhiaN0LndyDXac3BrIOafELgUlFJsv2ltkrUT8MnVfqbxl7eQ==
X-Received: by 2002:a17:907:7f19:b0:6fe:ce26:8f0d with SMTP id qf25-20020a1709077f1900b006fece268f0dmr15010594ejc.27.1653485920420;
        Wed, 25 May 2022 06:38:40 -0700 (PDT)
Received: from gmail.com ([5.38.225.110])
        by smtp.gmail.com with ESMTPSA id m15-20020a056402430f00b0042b607daf7dsm4942815edc.45.2022.05.25.06.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:38:39 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 25 May 2022 15:38:35 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] x86: Kconfig: Style cleanups
Message-ID: <Yo4xW+2u9obEt6Ay@gmail.com>
References: <20220525133203.52463-1-juerg.haefliger@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525133203.52463-1-juerg.haefliger@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Juerg Haefliger <juerg.haefliger@canonical.com> wrote:

> The majority of the Kconfig files use a single tab for basic indentation
> and a single tab followed by two whitespaces for help text indentation.
> Fix the lines that don't follow this convention.
> 
> While at it, add missing trailing endif comments.
> 
> Juerg Haefliger (2):
>   x86: Kconfig: Fix indentation and add endif comments
>   x86: Kconfig.debug: Fix indentation
> 
>  arch/x86/Kconfig       | 101 ++++++++++++++++++++---------------------
>  arch/x86/Kconfig.debug |  29 ++++++------
>  2 files changed, 63 insertions(+), 67 deletions(-)

Merged into tip:x86/cleanups, thanks Juerg!

	Ingo
