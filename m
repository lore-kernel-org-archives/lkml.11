Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9BCC04A68
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jul 2022 13:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbiG0N32 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jul 2022 09:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbiG0N3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 09:29:21 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D29724BD0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:29:20 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id z18so9052297edb.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IZC9NEhf05++/nyq+KA7I22wmZBHbNz5U6HDcm4S/Gg=;
        b=QUUOmuOPdKZaVDwP46yrsLjlhkNgx236+kyN/pzXLVNcxS/NNPOaK65eDooxwLXVTM
         7xZlGcil5YXcGY2dQxkP9AOJCuJWaniWL+0O0w4JQqZv26KEttY1pQEwaUdLFlj5+rET
         zt8oSojN1OGpy+0kYuNE3JOp1opZbgdI5BdAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IZC9NEhf05++/nyq+KA7I22wmZBHbNz5U6HDcm4S/Gg=;
        b=HcGlENP/vd7Lsaiy9v3e7bD0IfE7fKFWu9D+ujnt4/iIGOitNke4s90w3y6xmHS0qs
         VZS9enxv9NSTKE19z4CBVnYHUpsAyrlx623kaqLYizIqoX+MtTcv6yjgxahMioQ5TNT8
         lL356+Ev1e6qPz/GDJOjS0mMVDA5qUfm5THid/I1C0z4vPwVnQaatjiqzhHrNoH+/tmI
         NiaRTzW73wlWGFn9IGuyowQxoWuKRWAs7bhEem/ia/e5l9eMG4n8Ao5CyXGaYvNc3HAa
         mkieVwTsPh8AKJpQCmwrR+xtYt9+PV3Y/zKWV3OynxMPqm+HCvL2KXo0PJH61igGfdwB
         yNwg==
X-Gm-Message-State: AJIora8kgFhDsrArLJNem9nDKpcgO0D+7xpLOVac/7M3uhRbnnt6724f
        EOPvWCLH4jhLod9hGlnFHiJI79KDRvUU0AeUiDy9Sa2YbbtulQ==
X-Google-Smtp-Source: AGRyM1sR1qNmR47DsRJObhi68nvBusP+p+yzQluzwv7oyanNwWa7tQ/pkPkv8OVezPa2wPPBbBHcLYo2moJEHGpHtEc=
X-Received: by 2002:a05:6402:4247:b0:43c:12a7:6bf4 with SMTP id
 g7-20020a056402424700b0043c12a76bf4mr13170002edb.374.1658928559169; Wed, 27
 Jul 2022 06:29:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220713073217.2663078-1-williamsukatube@163.com>
In-Reply-To: <20220713073217.2663078-1-williamsukatube@163.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 27 Jul 2022 15:29:07 +0200
Message-ID: <CAJfpegt_pYg5ypOP+Epd5s=jg5K-g_drTPyOSAdy61d_-0PPiA@mail.gmail.com>
Subject: Re: [PATCH] ovl: Fix a potential memory leak for kstrdup()
To:     williamsukatube@163.com
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        William Dean <williamsukatube@gmail.com>,
        Hacash Robot <hacashRobot@santino.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jul 2022 at 09:33, <williamsukatube@163.com> wrote:
>
> From: William Dean <williamsukatube@gmail.com>
>
> kfree() is missing on an error path to free the memory
> allocated by kstrdup():
>
> config->redirect_mode = kstrdup(ovl_redirect_mode_def(), GFP_KERNEL);
>
> So it is better to free it via kfree(config->redirect_mode).

Will be freed in ovl_free_fs().

Thanks,
Miklos
