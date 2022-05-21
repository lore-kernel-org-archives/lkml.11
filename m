Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F3FC433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 21 May 2022 20:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244324AbiEUUED (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 May 2022 16:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241478AbiEUUDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 16:03:55 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E505AA62;
        Sat, 21 May 2022 13:03:54 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id k126-20020a1ca184000000b003943fd07180so6029077wme.3;
        Sat, 21 May 2022 13:03:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=bGSAKxQngDkXRyhhOs/u+FK3sUGPbu5OG43AWydY3Rhw/PWi74C/Me9CpUAsCAh5I5
         5gFQtvgKA8TYdQx/R/Sas6HISD40EdDwK2x8uJtN2UTS/3FYYga6PUG+Vjx4W541FBQu
         o3VM9V/9fYWv8F4kjHrqfnLyRxZXVkaH2V6hR5fyz1u+9L7ElX2b36bTWZEAHdBNtWU4
         pn0ibJZCtQFYe/epHZdBQhdhlBLRY+tu+WbjP3/tg9eGfC+mwl9ZD+EGM9+iJWnhN6i3
         PxksMu8vp2Hxh684r7zfZRIOpNLuy4SxhGFHfZ+MUw1mI17XTtDQc6bx2lMnrVRybwyr
         vfiA==
X-Gm-Message-State: AOAM532mkK3n+5cMCLHnV8Avw09LJH994dyQf6J/5Td9Kk1xr2dP65Iw
        wevIWF5agwmJcwEjDrghV7E=
X-Google-Smtp-Source: ABdhPJyZW5ziM6UlBJG70zl3q7Tkspea+ORr/TPPzygduyFNRkAiu/KjwAjKQLRTSHiV2m0n2eTG0g==
X-Received: by 2002:a05:600c:4fd3:b0:394:7fa6:2584 with SMTP id o19-20020a05600c4fd300b003947fa62584mr13376627wmq.177.1653163432813;
        Sat, 21 May 2022 13:03:52 -0700 (PDT)
Received: from [10.100.102.14] (46-117-125-14.bb.netvision.net.il. [46.117.125.14])
        by smtp.gmail.com with ESMTPSA id d7-20020adfa347000000b0020d098935dbsm5758822wrb.58.2022.05.21.13.03.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 13:03:52 -0700 (PDT)
Message-ID: <db25e5ad-37c3-8b77-2774-cac27b989781@grimberg.me>
Date:   Sat, 21 May 2022 23:03:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] nvmet: fix typo in comment
Content-Language: en-US
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        Christoph Hellwig <hch@lst.de>
Cc:     kernel-janitors@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220521111145.81697-26-Julia.Lawall@inria.fr>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220521111145.81697-26-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
