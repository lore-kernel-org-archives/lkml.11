Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACDFC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Mar 2022 20:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbiCEUdv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Mar 2022 15:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbiCEUdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 15:33:47 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570F637A0D;
        Sat,  5 Mar 2022 12:32:57 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id hw13so24094504ejc.9;
        Sat, 05 Mar 2022 12:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TM7AJ3oV8U7FFNZXKPP4XmzZhp+z4fppZRqXUBC++Es=;
        b=oxAiU4WHINe5aXbVEEPXKwclHX/bukULVnkmG1gef5WWbxTnrrBZjNtWaNjTLfWlIB
         MPyr3S8/NnwZFQEJvnYuAhJZJE8XQbxfkBbv22C5Xy8DfuERg0cTrZlyFup+wWP/3j8b
         evjRuIwZu8y3fP/rnhuoY4ohH1QcsPg8T/IGatQSQsNV5uYOa8P5PFdERiDMgtkwXu+/
         DynafjDZQIBVYM8bKq8RfgR91qkSvNpWKB4f1AzeK6zkExI13uLfLcy2z8olLecG38Wi
         kLTnffmOMU1ZNRo14VVrr027wlB1k0fwc08MKmDpPljJwfQmJoku3NZ8UdiuVvHv260G
         y64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TM7AJ3oV8U7FFNZXKPP4XmzZhp+z4fppZRqXUBC++Es=;
        b=BvJs//sASv9okaVtY6ONOPu0lbsKtwpRzUU7K/mAX3Sba/Bppu1xXu+jNMp7VVUoCR
         Frfdz9b7y32vEjOwoV/gU7M7InfoLJyLdlAr1PdDaQfG21REzdHRyo3A8Yi0HBsG+kbT
         8p1Sp7a/IYe65HDlCeJr4Hu/6LF0v5qehkvqIcJO2lPpIsmdokiaCsmVQ8CdeiOH+MP6
         iOkHoT8wSxTTFNZWOOkhvAggz7V6Qh8TUj5k6EezzxJJenpl3ZiqJy1/psntESNd/I8d
         30jEFapZxbsiwfQuMvUny8ncfLk/b+uWz0E8rXJOxjGIut7VxpXbF5YvM94r20YtBK7U
         EVoA==
X-Gm-Message-State: AOAM533tlM9dscwT4Ll5HwmK8Bg5lIzeZ6Pfy5QxqhH3IBE4V3sjbbLz
        Yq35qmSMa6WRK9STms70YbwZYlF2GfI=
X-Google-Smtp-Source: ABdhPJxp8ix2jRhbPodIgYkSU2BgAit7LXO5fGU5WCq3I57X+GzY+E7e81UPuJgiCKquWySlcwTc5w==
X-Received: by 2002:a17:906:4313:b0:6b8:b3e5:a46 with SMTP id j19-20020a170906431300b006b8b3e50a46mr3854405ejm.417.1646512375685;
        Sat, 05 Mar 2022 12:32:55 -0800 (PST)
Received: from skbuf ([188.25.231.156])
        by smtp.gmail.com with ESMTPSA id y12-20020a056402358c00b00415b3d2b79dsm3856201edc.97.2022.03.05.12.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 12:32:55 -0800 (PST)
Date:   Sat, 5 Mar 2022 22:32:53 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     trix@redhat.com
Cc:     andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com,
        davem@davemloft.net, kuba@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] net: dsa: return success if there was nothing to do
Message-ID: <20220305203253.jso2wergnn5c7fsx@skbuf>
References: <20220305171448.692839-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220305171448.692839-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2022 at 09:14:48AM -0800, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Clang static analysis reports this representative issue
> dsa.c:486:2: warning: Undefined or garbage value
>   returned to caller
>   return err;
>   ^~~~~~~~~~
> 
> err is only set in the loop.  If the loop is empty,
> garbage will be returned.  So initialize err to 0
> to handle this noop case.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
