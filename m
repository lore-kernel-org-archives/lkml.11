Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E6CC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Mar 2022 07:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243886AbiC3Hlr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Mar 2022 03:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243882AbiC3Hlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 03:41:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 13CED51592
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 00:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648625988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bdmc0ujk/QGKxeijeYMWGwM4/XVziFQYge7M2egdNzo=;
        b=bUOReHxYExyU7JcUzVjPEHvegpwBg7VrkBHpccUI8RVRzjkiIRhSV5niEhcTQgvebNTptv
        kpd5qt9XqWX+3t9CahEWMCWYn7Qq/CkEne4bTqG84/DtGly6Gnz2M80SrvukEh32vTBHe9
        doHaKYkFIBqR2F+GyICgRMd0+cA8JR8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-465-s7iNRnFKPD2FmvYK6lx8nQ-1; Wed, 30 Mar 2022 03:39:44 -0400
X-MC-Unique: s7iNRnFKPD2FmvYK6lx8nQ-1
Received: by mail-wm1-f71.google.com with SMTP id c62-20020a1c3541000000b003815245c642so685430wma.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 00:39:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=bdmc0ujk/QGKxeijeYMWGwM4/XVziFQYge7M2egdNzo=;
        b=FRXwRS79NlNW4FPI4D4Dq6a3vKUDnp7SlhyJUf0aIQW0A+/PTfeufD0/VKDQPKYbM6
         w0GzYzmLdKftjMO4K8KtYo1fOJSjS0O6Xe3yDJoUcGjKvzIzoyhKhJ31Si2EnMYXNt95
         oLH++LJ3Yvx/rFbAnov/Lm/BfTTc57MwtwUKv9V5Yb3nASvz75N5T/GM/WrxVXa0Mt2X
         Zcow9gsKEsVpxuHthpRfx5hRC3WPMNWvXPXuCvWcy0fX9/+FMTXqgSmjcSo5T8X/bOzj
         sjHq92pd44co7haifsDkP8QGu2S7pUc0XSpjIULiz80BWMzDYq3WceNobIqW14ndcKxg
         nWBg==
X-Gm-Message-State: AOAM533GJt7Dwb2vROyP1dZtyDOOQlUxKdxwBvpw2TbS1ezB5aF7qD+I
        ASZpJcwdV0kk/oF3+wAcX+PZcQQSH8yNu3uX1wFG2WwUpci+yF7+xtu8w21ekHj2wfBpGnz72KH
        G3Po3+JeWsP64KN1PLVNyaVGz
X-Received: by 2002:adf:eb48:0:b0:203:f854:86cc with SMTP id u8-20020adfeb48000000b00203f85486ccmr34346332wrn.102.1648625983768;
        Wed, 30 Mar 2022 00:39:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxD6/4KA9nOXr+UYw0G5RCCghSOQawlwc82iZvSTIsHhrWRBJJtIxg+6ty0ZAU8K5GX9wFrWQ==
X-Received: by 2002:adf:eb48:0:b0:203:f854:86cc with SMTP id u8-20020adfeb48000000b00203f85486ccmr34346324wrn.102.1648625983566;
        Wed, 30 Mar 2022 00:39:43 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:2200:178b:7244:2a1f:b5d8? (p200300cbc7052200178b72442a1fb5d8.dip0.t-ipconnect.de. [2003:cb:c705:2200:178b:7244:2a1f:b5d8])
        by smtp.gmail.com with ESMTPSA id bg42-20020a05600c3caa00b00380deeaae72sm3818045wmb.1.2022.03.30.00.39.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 00:39:43 -0700 (PDT)
Message-ID: <a9844884-c591-b26b-abe2-953c896b8c95@redhat.com>
Date:   Wed, 30 Mar 2022 09:39:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [Patch v2 2/2] mm/vmscan: make sure wakeup_kswapd with managed
 zone
Content-Language: en-US
To:     Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ying.huang@intel.com, mgorman@techsingularity.net,
        Miaohe Lin <linmiaohe@huawei.com>,
        Oscar Salvador <osalvador@suse.de>
References: <20220329010901.1654-1-richard.weiyang@gmail.com>
 <20220329010901.1654-2-richard.weiyang@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220329010901.1654-2-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.03.22 03:09, Wei Yang wrote:
> wakeup_kswapd() only wake up kswapd when the zone is managed.
> 
> For two callers of wakeup_kswapd(), they are node perspective.
> 
>   * wake_all_kswapds
>   * numamigrate_isolate_page
> 
> If we picked up a !managed zone, this is not we expected.
> 
> This patch makes sure we pick up a managed zone for wakeup_kswapd(). And
> it also use managed_zone in migrate_balanced_pgdat() to get the proper
> zone.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> Cc: Miaohe Lin <linmiaohe@huawei.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Oscar Salvador <osalvador@suse.de>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

^ I'm not so sure about that SOB, actually Andrew should add that. But
maybe there is good reason for it that I'm not aware of.


Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

