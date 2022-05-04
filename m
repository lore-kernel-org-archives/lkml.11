Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FC2C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 May 2022 04:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344602AbiEDEhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 May 2022 00:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbiEDEhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 00:37:33 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3109028E0F
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 21:33:59 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id i17so387945pla.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 21:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=4xLhBgyjCW7fK1KFnT3xF79l/RZiEXjV7m1gD8SiX7s=;
        b=mSmducHRDLifGsLfPmk3lVYTIPKG9k2/GmAVch1z99MosumpH2st6KcBkFmK7V+1fJ
         I+jrrWyaJOTjeCNow2f/NrXSUDg90M7hZjHZS7+d+bymw9+D0buyZAGZvC76VsxL+0Wh
         z1txWVdH/VyvlTe1IzsUbT3dUvYqSeT5JmZnd+gGnwQtZ35aoTEWjzwzKci9MF2avRrb
         aK5L/BV8Q0jxlmuiPwtvQEPDMcxUNY5YiMp3eUncIFbz0fxmaOPHQmC5LZTrjXk+I4+U
         lRHfjDqsqa/TaRZdfZbLH6WiMEYoFi0v4LZ809BsPf5RhmVmVmARepv+Kg/SoIL5/jJt
         kZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=4xLhBgyjCW7fK1KFnT3xF79l/RZiEXjV7m1gD8SiX7s=;
        b=IQnDiGPTbCuMv1+8tzWJtmovfeiS36psEUGJal2DZZOlBbIctcdjrJKj8KNQW1AKBH
         MRvC6RQld4tp4KOxnDaIUqTbNa3wzTBDuCZ+5JQCMYYJI98Q9SPuq3UWdPZp3A0T4gLx
         qKOd3lEtjk6v5sk3tCQXMoL/4r6uF2TnBq9TU/nLrBoOhKMguiskXKt+qRUUzPjCs4wn
         y9RPhmh8jJM4aBu9uajKvk88Jxq2pSPIedDqVSRkM/oLk1nIkZ4jlkfc93eq77zTCe66
         dukLG0/KQ4DeRm8etuVMw74UM+ZgEfzoEZ8rWordjfdFX9xeuSxEomvfaPwtJV0y1yS3
         wjdg==
X-Gm-Message-State: AOAM530XlkrFj8O5uR1P/bnkghbwrbV3av0/GeHDOKQMj/HWlx97GDwh
        l+59dyjRmZCSuwG/FMHTAtj46w==
X-Google-Smtp-Source: ABdhPJzsi7qjTPEvFIOZeCXAUs1SxGn5zLdtBfvzJlhtnHLke4+pMibII8XuS7ttO++6rGJaYZNIMg==
X-Received: by 2002:a17:902:cf05:b0:156:9d:ca01 with SMTP id i5-20020a170902cf0500b00156009dca01mr19770474plg.111.1651638838532;
        Tue, 03 May 2022 21:33:58 -0700 (PDT)
Received: from [2620:15c:29:204:81bf:3703:f79b:1d5] ([2620:15c:29:204:81bf:3703:f79b:1d5])
        by smtp.gmail.com with ESMTPSA id k18-20020aa78212000000b0050dc76281d8sm7325331pfi.178.2022.05.03.21.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 21:33:58 -0700 (PDT)
Date:   Tue, 3 May 2022 21:33:57 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
cc:     linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org,
        yosryahmed@google.com, hannes@cmpxchg.org, shakeelb@google.com,
        dave.hansen@linux.intel.com, tim.c.chen@linux.intel.com,
        roman.gushchin@linux.dev, gthelen@google.com,
        a.manzanares@samsung.com, heekwon.p@samsung.com,
        gim.jongmin@samsung.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] mm/vmscan: use node_is_toptier helper in
 node_reclaim
In-Reply-To: <20220416053902.68517-3-dave@stgolabs.net>
Message-ID: <db75e14b-18b9-ffc1-4b3b-16ef2956f2c@google.com>
References: <20220416053902.68517-1-dave@stgolabs.net> <20220416053902.68517-3-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Apr 2022, Davidlohr Bueso wrote:

> We have helpers for a reason.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Acked-by: David Rientjes <rientjes@google.com>
