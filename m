Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57404C00140
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Aug 2022 16:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiHJQl3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Aug 2022 12:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbiHJQlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 12:41:25 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACF01101
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 09:41:23 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id z22-20020a056830129600b0063711f456ceso3062916otp.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 09:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=XTiTJ4FxwpWw84LKiNSYSTO/gnrN5qUZqhqmKW/Gh4w=;
        b=iga87Q0F4KLtml0NyMbtr1doo/KawlNydW0obAC9W9XBiNKTLuc1dMMr/L4myWJJ96
         RjUTWxAXFZr3TjlQ21zg9Of0DCXVXPRilL9UrcA8kO7QEhdtNkFddzJx/QOHI8CbQWIm
         7W4UcXySZoD/kMnHqpgnbDT3yf1ctBtw3XpjfDz/Nv3fYhMV3x1Ui3sG8O73WGnfFMAe
         Y7LRSZCv7bOs1dQa/KbAX9s7/bHvJnL0OAzEIqFm0nxq3ObFt0VMZrAPsC0ZvUDh/IZ6
         4hVNzZlY6ScDa9WRaxIODBundsFeu2eK/lej7WY//Sp2ZdQVZX4euO6ivO6wgJNB8C4U
         J1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=XTiTJ4FxwpWw84LKiNSYSTO/gnrN5qUZqhqmKW/Gh4w=;
        b=Dvf3qYx4IPcvtJ651ncKTVil+sZkqpnPV2fLeqS6wes+RFt+HS6yalIsYvN5h7GVGr
         9xwts3T+D3FSVxcO4BT+umZt5pzKLSj5WZc4W7iHpH96TA8/g989yIhtbwn7ayA0Ke4V
         MKRIImxCMyJOlDMssCq+4i2HNcvE3/qBbdz/rIukUlFjbXdn5hXdv+wWkZ6gzHiFoAxU
         ZUJADGTVCm2a0AVUIAsCEijA9aFjxbtGcOGK6KMRGaHgEqjmZs0jWbQkT35jDs7ggSkb
         tqNv/GU4a/LP+f0xNaGS29CjB1o3ZQQ+9aApMt+ayQ4Zw2MvW+d6OtXWgRzQzeq+KRN/
         BEIw==
X-Gm-Message-State: ACgBeo1A6xMRox/HPIpb55av0+C6OlHmnBWqAmfXB6L/1IfFcCy8HHFx
        N4ZMZWe36JlnvWO7lXBk/zACkrbVnTZsl9/H1gTwtczt
X-Google-Smtp-Source: AA6agR6wR4ecNZe8+daGyRZM7VDRQFe/FZPJGUKIa38dUFuAS7M6VAf17HivKhzzWW1T/4Ni+myaw/45sJblGkIs5ZM=
X-Received: by 2002:a9d:c64:0:b0:636:df4c:e766 with SMTP id
 91-20020a9d0c64000000b00636df4ce766mr5897353otr.12.1660149682412; Wed, 10 Aug
 2022 09:41:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220730034923.25500-1-mailmesebin00@gmail.com> <31187f41-64c8-d7ce-fcf2-5da421b3e194@igalia.com>
In-Reply-To: <31187f41-64c8-d7ce-fcf2-5da421b3e194@igalia.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 10 Aug 2022 12:41:11 -0400
Message-ID: <CADnq5_OOWekUj-Y8Y64=vUUMfUmEXUyQ1Ougmqj2afKtu6hdNA@mail.gmail.com>
Subject: Re: [PATCHv2 -next] drm/amdgpu: double free error and freeing
 uninitialized null pointer
To:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc:     Sebin Sebastian <mailmesebin00@gmail.com>,
        Tom St Denis <tom.stdenis@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
        David Airlie <airlied@linux.ie>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, Nirmoy Das <nirmoy.das@amd.com>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Aug 1, 2022 at 1:08 PM Andr=C3=A9 Almeida <andrealmeid@igalia.com> =
wrote:
>
> =C3=80s 00:46 de 30/07/22, Sebin Sebastian escreveu:
> > Fix a double free and an uninitialized pointer read error. Both tmp and
> > new are pointing at same address and both are freed which leads to
> > double free. Adding a check to verify if new and tmp are free in the
> > error_free label fixes the double free issue. new is not initialized to
> > null which also leads to a free on an uninitialized pointer.
> >
> > Suggested by: S. Amaranath <Amaranath.Somalapuram@amd.com>
> > Signed-off-by: Sebin Sebastian <mailmesebin00@gmail.com>
>
> Reviewed-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
