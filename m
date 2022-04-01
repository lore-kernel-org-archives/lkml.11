Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D861C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Apr 2022 03:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242166AbiDADff (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Mar 2022 23:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbiDADfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 23:35:19 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408C4393E2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 20:33:28 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-2e5e31c34bfso18936397b3.10
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 20:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q1ZlIMdqwaHcVxl5vxdhmKHFJeu6p9U+TnfY5JmQ5dM=;
        b=cCsLEiaIgCsxr9TWzXMTho+oGCR5boSOsvIae/bdzdTwg7lOuuOdjz3sFy2I6rxLQN
         8gCPt4vkHPMA3zN5dXdcS14XF0dMbM0/MUleoQHqW7DH5ST/f9RLqI1ieI4tu7otfMXD
         wlVW9+NT2AU/WoLZB9jxlgcmJ/BA1zJd+J104=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q1ZlIMdqwaHcVxl5vxdhmKHFJeu6p9U+TnfY5JmQ5dM=;
        b=BZLz0KNiXRwGOZE24iTLqvdCcLY3sBuTo1T97IVnOaI+DKVJm/y0MMOjDdh55mIJg6
         eMBoi0PYXsNtXANg2+OsHj0/NAeppON/b4RWQyRR4Z1wKNdPi2cZUiPBFQGAs6vILKcs
         8EtizelOC/aS+Z21cHGrNM/cyRkBF0P6vBv0MdibLi4ybiVsphOg+nHNTi8yQlqVnAts
         mS1vWEPDvXD4d09rtdmXNsjAyDNt1jJ/L+ixT1ceAi1Fk/yrprqASuSKonSB33G5dx66
         oD7usu5b4KJgU1W3jlfmw7KoidnKCG3qVlElGUXNQuM5dxbHAMUEFkEjgGLp+M6BGCxM
         DWBg==
X-Gm-Message-State: AOAM5329X0MOnUjWxq+kfgWLxCYGtuW/ilXoG+jc5UlSRdBLPPG6PyNs
        PIlEe9p9u/9zXN9wRRrPSlPbusiNopfjKwKVKqAfYA==
X-Google-Smtp-Source: ABdhPJwgwC705No/2HiCCuHkqrpend2/Epyo4yRvnIvyPJ3Ajg9/yTBw5Ox0LS4mT6R08xeM54qpyiyIa+UXx3wCyTM=
X-Received: by 2002:a05:690c:398:b0:2e6:17c3:44d with SMTP id
 bh24-20020a05690c039800b002e617c3044dmr8410985ywb.286.1648784007571; Thu, 31
 Mar 2022 20:33:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220331091628.641915-1-wenst@chromium.org> <YkYMo3cU2lqeDBu1@eze-laptop>
In-Reply-To: <YkYMo3cU2lqeDBu1@eze-laptop>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 1 Apr 2022 11:33:16 +0800
Message-ID: <CAGXv+5HgK2Er5Ks8J-yj16kY-0q3vQyUJRJVcTQORQY4Rh=zzA@mail.gmail.com>
Subject: Re: [PATCH v4] media: hantro: Implement support for encoder commands
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 1, 2022 at 4:18 AM Ezequiel Garcia
<ezequiel@vanguardiasur.com.ar> wrote:
>
> On Thu, Mar 31, 2022 at 05:16:28PM +0800, Chen-Yu Tsai wrote:
> > The V4L2 stateful encoder uAPI specification requires that drivers
> > support the ENCODER_CMD ioctl to allow draining of buffers. This
> > however was not implemented, and causes issues for some userspace
> > applications.
> >
> > Implement support for the ENCODER_CMD ioctl using v4l2-mem2mem helpers.
> > This is entirely based on existing code found in the vicodec test
> > driver.
> >
> > Fixes: 775fec69008d ("media: add Rockchip VPU JPEG encoder driver")
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>
> Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
>
> I believe Nicolas tested the patch before the splitting,
> so this is probably Tested-by as well.

The code flow changed, so I believe a re-test is warranted.

ChenYu
