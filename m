Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBA6C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 24 May 2022 07:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbiEXH0t (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 May 2022 03:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234675AbiEXH0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 03:26:34 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2771582F
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:26:33 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id p190so2482581ybg.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gJWKj2F93NghAWdlsPXaL6PXsu2REAfRhsHMxfDodds=;
        b=GVa7L31SPkXGRtdqRY4xJ1bZ0GY6Y3XUnFaYwEvm1BNaY5qE1EHXs4O34BrzfBBLGT
         kXKVxAh73GftnNjF8xA5GJUuhINikT3k5JRm3NRucHv8/ph+2rutnKYz2DEDAKWScwNf
         Q28sXE/5q5iiU6hiY8gsxvG+k2rcLdKGkvz41SSnYDf4fkJkRyChk7hRS+CW9x4gQK8o
         8aNkqnWhnSknzqam7R02yw4pDG1ALsm24e61kHewJuVdKJTrJQYzdUuoleBCCa8AiZ0y
         EmoLeY0nDk6Q3kDWZWToeUTZW3H2dDIxrllKbG9CprvFc6ljJx04fovi1ukjyQvD4WYh
         ssJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gJWKj2F93NghAWdlsPXaL6PXsu2REAfRhsHMxfDodds=;
        b=TDyVLTlaxnEn8gr212dmGwcWgaFVCM/WNsdSilsUjfE3VzU3l3RmAkLvKo+WlO1xYk
         7FxXvIDuFg0OzAjd8FexR2VEKNYKPSHhsSuSBuFM7f4iBGH66BGhmgWLgY7Ub0P6D2Gp
         d7HPjzO1peFRMr1ha2zKl2OrO1HsKNxB4po2Bc4rgu5mWDZTj+d8btWkIdid2Qs7TU8E
         WvUQnOkyCq+0h+DACyJz5bpu9cbpDQlDq0LcXh3mf9q3o2Bj53vjuV6KfB39R5hYACqr
         OxcihyVbnfWvXnahT/USb+/UsUOPoHP7GUtVeLS8OCdKGxPhFCJEQaK+jJmokdOFIE8y
         C8IA==
X-Gm-Message-State: AOAM531UueZUS1MDCbcJl+yRWIR8byomsy+UBF3eeBB7Povb8ZL5B+PY
        qDW/4bIzJetLP3zQFpUWoCkGwMm0X3Y4j814Exv37A==
X-Google-Smtp-Source: ABdhPJzHKwBmWdk7X6ijDIcbH7VCh5ViEnNHyoGaOSsJkkOCwAPI7g5KLD8oEqJBq/k3mckknqmLtth1uFFb4CONS5k=
X-Received: by 2002:a05:6902:526:b0:64d:b6ab:f91d with SMTP id
 y6-20020a056902052600b0064db6abf91dmr25689763ybs.295.1653377192575; Tue, 24
 May 2022 00:26:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220523143255.4376-1-linmq006@gmail.com>
In-Reply-To: <20220523143255.4376-1-linmq006@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 24 May 2022 09:26:20 +0200
Message-ID: <CACRpkdaJQUY_gaHFqyUtdq2RNry5oGdDxO3T9EjVa9bd40enMQ@mail.gmail.com>
Subject: Re: [PATCH] mtd: maps: Fix refcount leak in ap_flash_init
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 4:33 PM Miaoqian Lin <linmq006@gmail.com> wrote:

> of_find_matching_node() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> Add missing of_node_put() to avoid refcount leak.
>
> Fixes: b0afd44bc192 ("mtd: physmap_of: add a hook for Versatile write protection")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
