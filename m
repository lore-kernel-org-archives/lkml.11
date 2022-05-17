Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF9AC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 May 2022 17:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351321AbiEQRGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 May 2022 13:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350480AbiEQRGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 13:06:48 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD7513F0E;
        Tue, 17 May 2022 10:06:47 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id n18so17909885plg.5;
        Tue, 17 May 2022 10:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jf4s8QIDSrOKg81HbuSA52ij+q0WBYhYTRAF+5w+aLk=;
        b=VtoWTUwBib/p6g9+5Y6v7nCk/SG4snA+neR+JdtetOycCsBah4LsINBvKMmAVfJtbR
         VbiMQdF3H+44sT0KlE99hveW4lREXTpNV7FbX1ZjPTQGDakMHFYGIGYAvVsk/RNBOdIA
         lNJuw4/hWrPpWYmDGJjQUeJTXttNjagmUPdfKaYkFjSw42oqlfPmIaUhR6b1uOyHihot
         O4q3FiZOfGQwlrJ0v52lIES4ktkkdYtvY6bW7STRDlnYNlND0CIUTNX7pqtuAf9Vchv5
         pzqkTDAN+l+uYcWxT1e+knThpmgWlXfPDZiwbUF996JX6DRDdSh2ttcOQqpwo6eUTUEa
         68gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=jf4s8QIDSrOKg81HbuSA52ij+q0WBYhYTRAF+5w+aLk=;
        b=N+j4TvhGeIlm70TvLs/dk8u+lHMQs64Dnw7ea21Xm3K5h5/foUdPCS+BEG3HGfAInY
         WN7Jd7ddfYK1kH8zyg3FCGkyEmTW4JbrJpU6q6YgBahltu9ylUsJ0bToQc2c0pYT15T1
         lXEbi9orsWWaas9+JCo0/a25yXv5ZVH/z2jFn1HUV7x7svE0MCO8f+U6H/A/7bpUL2qt
         UrdVG6pQbkpKlb6orodM+IwiNXct0S7NnVq3nlf5IGmXPbnEulKwwJ8L/63gMsc7GsDe
         j/7g4PXHVYf7fcZ5wooftJ5l3yFuN+SkvpjWEocrTh8sWL+DTTw6U1Klo2n6qZEsrYlp
         rE8w==
X-Gm-Message-State: AOAM531EgZ9SvMiaZ4BHAuxmOKyX8cAYw/OCAdJM63iAT9TrK/aSjInA
        84y923msqTobVHcOQ4ZI/d8=
X-Google-Smtp-Source: ABdhPJz4AblXIcsEbqjaQugQkMe1qhL8/pRfBDu5PyZhHLvvgYfnJPNg4/HDL8FWaa3KNOAH05eBMA==
X-Received: by 2002:a17:902:bb90:b0:158:a031:2ff2 with SMTP id m16-20020a170902bb9000b00158a0312ff2mr23462620pls.117.1652807206983;
        Tue, 17 May 2022 10:06:46 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:62fc])
        by smtp.gmail.com with ESMTPSA id p3-20020a170902a40300b001618645a902sm4039447plq.155.2022.05.17.10.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 10:06:46 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 17 May 2022 07:06:45 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] cgroup: Make cgroup_debug static
Message-ID: <YoPWJZ+RJmlvBLwV@slm.duckdns.org>
References: <20220517112523.243386-1-xiujianfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517112523.243386-1-xiujianfeng@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 07:25:23PM +0800, Xiu Jianfeng wrote:
> Make cgroup_debug static since it's only used in cgroup.c
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

The only thing it does is gating CFTYPE_DEBUG which isn't used anymore.
Can you remove both CFTYPE_DEBUG and cgroup_debug() instead?

Thanks.

-- 
tejun
