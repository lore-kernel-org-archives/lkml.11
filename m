Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08B2C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Mar 2022 17:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237274AbiCIRRX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Mar 2022 12:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236943AbiCIRRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 12:17:06 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345BF97BBC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 09:14:27 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id 9so2526424pll.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 09:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=bPb2hXJwz7Uq48yOO7RX4kUFEFj7fT1cNUovngBDF2w=;
        b=SA72OkIAKBGrZq6UtuNXYGJXBYmJtE1M+kfDg320yWGHlcP+RMtxbjTihjPYyNQSp5
         W+dW47jsgLKehm/0m36qIiPboJHgkUPAUbRuLB9dyZWEMxRV5cF1mgO7JdYGQmKPvi71
         QXeuqH/dbGYL9fuDiIl9UDQ5Bu3pLs57VtlfDVwV83UTe+0nVMqWQ+6kh/gBtFyLBA57
         pgH8s2I+61hM5adnUacSCqruTPt+752KXjj3sfsb5u9tS1HtlIusaaK7RQSSmkeEUK7Z
         XKq22foc/eKT8DZ1X9JrY56VrfgnPDf2OP/xngr9bLwD8zVMetp4IePfbuRS3CecDHV1
         wZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=bPb2hXJwz7Uq48yOO7RX4kUFEFj7fT1cNUovngBDF2w=;
        b=pAdHWA+V7UcNFwoS8d9et/f8JsoN39xyTe4CM3cUWWPkWLyUK3d09k4DLeugqJUCTU
         VRQMy93qiZdjQeQKgH/hqARtBU1x4lbOqGlyDYIV1AJs8oK49oZu6e9oeG97Jcvj/thd
         8p+U6+kfx/U/axfDWdWn8pb2wzUHfdEtbMeYkjoHzeDcywbRBpjUoyBO2UHbL5KXEeH2
         CjYCRU/CtcsxweKuG1aEBEStWwOoPEoYOlTR/6sUOjqyrSAKsjrosiw7m2MZ2G+KNHMo
         t7wwcKFPVxgw77NJTaWcfUZnhwllTJNGk7gqEl/bdHt8d2F1k2oOAq6rT4cXSoY/is/L
         Tnwg==
X-Gm-Message-State: AOAM532SV3ZigoxZ8YaxATxBHJleLSJ4y1WnTZh5hjhhsdAE1CGbYs5V
        ueiSv5xXQp46Vh/2vAxsKzaHFQ==
X-Google-Smtp-Source: ABdhPJys1pu2xm6FSo9OConeb+bND1rOoYokKcZ1PMbIFkXZ9eLbvhslK1qr/ISk9SdesfSVSQSSwA==
X-Received: by 2002:a17:90b:314e:b0:1bf:38a0:8e6b with SMTP id ip14-20020a17090b314e00b001bf38a08e6bmr11541872pjb.22.1646846066279;
        Wed, 09 Mar 2022 09:14:26 -0800 (PST)
Received: from [2620:15c:29:204:b5b9:5c22:b3dd:17a2] ([2620:15c:29:204:b5b9:5c22:b3dd:17a2])
        by smtp.gmail.com with ESMTPSA id c5-20020a056a00248500b004f6b5ddcc65sm3676463pfv.199.2022.03.09.09.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 09:14:25 -0800 (PST)
Date:   Wed, 9 Mar 2022 09:14:25 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     sxwjean@me.com
cc:     cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz, longman@redhat.com,
        guro@fb.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Xiongwei Song <sxwjean@gmail.com>
Subject: Re: [PATCH 1/2] mm: slab: Delete unused SLAB_DEACTIVATED flag
In-Reply-To: <20220309145052.219138-2-sxwjean@me.com>
Message-ID: <6b5858d7-2d19-a57e-b840-9616e3f5d892@google.com>
References: <20220309145052.219138-1-sxwjean@me.com> <20220309145052.219138-2-sxwjean@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Mar 2022, sxwjean@me.com wrote:

> From: Xiongwei Song <sxwjean@gmail.com>
> 
> Since commit 9855609bde03 ("mm: memcg/slab: use a single set of
> kmem_caches for all accounted allocations") deletes all SLAB_DEACTIVATED
> users, therefore this flag is not needed any more, let's delete it.
> 
> Signed-off-by: Xiongwei Song <sxwjean@gmail.com>

Acked-by: David Rientjes <rientjes@google.com>
