Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D55C433FE
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Mar 2022 11:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346506AbiCHLcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Mar 2022 06:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244724AbiCHLcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:32:09 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D95945AD8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 03:31:13 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id c20so5594799edr.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 03:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zagytqRanMqmGZPaeZYMEhXfaOgjty5ndKR4qYehJqg=;
        b=Jq82/CxYirJBuGuzNePcQu1UMKXNY25JLT1l1ke+oJN/zLSj/FOppoJPENL2MAfIRu
         s1E2/pOfTRUVkqNWvjm67jtEzW35jGuM/8l8qzKbpkQECw3jdZNUIL7T8QYJGQUMlVuD
         ab6yomX723E3XEgtUqrjFyx+SGPGdRPK1arQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zagytqRanMqmGZPaeZYMEhXfaOgjty5ndKR4qYehJqg=;
        b=X8q7xFD7R+t/O70GDH9WdRgJUXuX7HUOEPtoYjuIZCaf1EYBCCU58NchgRCpriu8J3
         i6QYC5Z90emICzmErLfwpW4UsJ7J+2c/BciZpNyAxSqfieaDj95Px8u/EzMzHaDOr0Wo
         aj2wtPD4LuwGkpejo5bFS82ylte7lC6DTywseaPUIPgheZLusDXJNadBF7AhKxRsoA6k
         +bA6DgkDXwCwe/D0eZ0J9IxLmSbSZuJRhFRA5RAYa2IDDMkGXq7j4nOxbvxVTh1L4RIY
         WiPNQ8FbsmR/fHhEcMipeuntbR02T7xXWTSl9eLaDB/P32nW9fXffDXC1rIs9XZLRLsr
         Jwig==
X-Gm-Message-State: AOAM532XoEhi2relIDxVg8C+qUQHggBRsp5CNZp3Pq6729kcjTp+m/Aw
        LCEIm/XfPA1CvXRnozXq7+fRQw9v/LhugwxJBYhl4Q==
X-Google-Smtp-Source: ABdhPJxdDz8gEfcI9ebtRv8bH5oH/qYk7ojEEaPFHDFMMzuPbrutVm4ZhylyTOEujsY/zbd3Ky9zCzsYQMte2sBKUsk=
X-Received: by 2002:a05:6402:278e:b0:416:5064:b39b with SMTP id
 b14-20020a056402278e00b004165064b39bmr7820528ede.157.1646739071790; Tue, 08
 Mar 2022 03:31:11 -0800 (PST)
MIME-Version: 1.0
References: <20220228182904.22982-1-jose.exposito89@gmail.com> <164673846305.2436174.1857157702611077242.b4-ty@cerno.tech>
In-Reply-To: <164673846305.2436174.1857157702611077242.b4-ty@cerno.tech>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 8 Mar 2022 17:01:00 +0530
Message-ID: <CAMty3ZAC1vj8Kc2tKP4wL5O15W7FA-OWf030JcTKRs9feDLejw@mail.gmail.com>
Subject: Re: (subset) [PATCH] drm/bridge: parade-ps8622: switch to devm_drm_of_get_bridge
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        andrzej.hajda@intel.com, jernej.skrabec@gmail.com,
        narmstrong@baylibre.com, airlied@linux.ie, robert.foss@linaro.org,
        jonas@kwiboo.se, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, laurent.pinchart@ideasonboard.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Tue, Mar 8, 2022 at 4:51 PM Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Mon, 28 Feb 2022 19:29:04 +0100, Jos=C3=A9 Exp=C3=B3sito wrote:
> > The function "drm_of_find_panel_or_bridge" has been deprecated in
> > favor of "devm_drm_of_get_bridge".
> >
> > Switch to the new function and reduce boilerplate.
> >
> >
>
> Applied to drm/drm-misc (drm-misc-next).

Not sure whether it was intentionally or accidentally applied? the
same patch has sent before this date and has sent the v3 a few hours
ago.

https://patchwork.kernel.org/project/dri-devel/patch/20211210174819.2250178=
-3-jagan@amarulasolutions.com/

Thanks,
Jagan.
