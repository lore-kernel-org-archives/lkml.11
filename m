Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02251C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jun 2022 10:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbiF2KB7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jun 2022 06:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbiF2KBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 06:01:53 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72383DA77
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 03:01:51 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id v126so10676353pgv.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 03:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=06ETpuMkkHvgkjlRcUOfW3Fbdi0cQVfE/Mqnw8Cfz6c=;
        b=Z+DdzGQCOPMWgnRlG7eFR3++KN2JGZInwRICpUOLLpqkx2IqLJFYiPE47vbXS1M7JZ
         k3dBjYEgqg78UAgVBFY2pwz5JpwYtepipTJYYxwuIoIUuP5JxEfD+nfiFcBKqeF03ycP
         iXM2XlNp7Yy8tyP8WcNfyxrCw2Rqkywr09QZhnjzI3P0NvFFLMoEvoJCIhQs/n+r9q0C
         nftPKoUNQHGMtw6rkvD7cv2qg65N0sWjsgd81B54w4c5ESm5qN/yJl8HsfhfcW5CSyyI
         gshmwI0JOZqQF0PNQmq+IM/Fc00D2tISqKkflocSf8xRPkE8kRhbSXyNcERixq5pUFZs
         VDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=06ETpuMkkHvgkjlRcUOfW3Fbdi0cQVfE/Mqnw8Cfz6c=;
        b=IWy902rOgHCoNwv+rvXwGz7IhB3KLP7ntUkmZPemKeJEldlIjPoTQ2yVLG77DexT0/
         kb6wK0mJtSMtETHKoPvAqviBhBBzEAzNeuh8HEktC+XQ08whA0Ue9gESuv6eZep0U8X6
         3Q5ChATi1WxdkkRTIwhNXWo8qGq2f/7uwSzImIfX8jwSbjMlNhIPSCTxN0V5E2UUVCgZ
         v85wkzCTj2+YiDHJk/I1WpRzmvQ4xQRPOfpwOt6nURJPjJQhWslBmLiJski0aa2Iy37d
         tiAAmZkaHShBWEJh4Ejqk1U/R6GwgKX+XJ8CWQAbAgAr1RLC/qNpNY9gBAVlXl/7mECy
         6nqQ==
X-Gm-Message-State: AJIora9x60YYxR6LpfbvynD3q+FDXZPaRCljnPFAidd8zF1x/YHsyg0N
        oeGIH1gYdeaIA4BpXljSTVsciQ==
X-Google-Smtp-Source: AGRyM1u3TUNiIcqmMzXOhJVXBVjarrFFI/oXzgv9p8odXVYl86MN3Ot3cWjxvyYtnW9QUQTXGp/5mw==
X-Received: by 2002:a63:481a:0:b0:411:7951:cbcd with SMTP id v26-20020a63481a000000b004117951cbcdmr2346233pga.66.1656496911163;
        Wed, 29 Jun 2022 03:01:51 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id a8-20020a656048000000b003db7de758besm10992476pgp.5.2022.06.29.03.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 03:01:50 -0700 (PDT)
Date:   Wed, 29 Jun 2022 15:31:48 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     daniel.lezcano@linaro.org, Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-pm@vger.kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        rafael@kernel.org, dietmar.eggemann@arm.com, nm@ti.com,
        sboyd@kernel.org, sudeep.holla@arm.com, cristian.marussi@arm.com,
        matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Energy Model power in micro-Watts and SCMI v3.1
 alignment
Message-ID: <20220629100148.67kevfelqq7d23n5@vireshk-i7>
References: <20220622145802.13032-1-lukasz.luba@arm.com>
 <be793e51-0d89-7afd-e122-ec929a1130e9@arm.com>
 <20220629095302.bi3xx6yicsnjeff7@vireshk-i7>
 <1072cb84-4097-0cbd-f980-a864ea851b0c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1072cb84-4097-0cbd-f980-a864ea851b0c@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-06-22, 11:00, Lukasz Luba wrote:
> Thanks for fast response. It would be great.
> 
> I have 2 ACKs from Sudeep for the SCMI part,
> but I don't know the status e.g. of DTPM
> current work which is using the EM milli-Watts
> and does conversion to uW internally.
> I hope, I won't make issues to Daniel's work with this
> change.

Daniel, do you have any objections to this ?

-- 
viresh
