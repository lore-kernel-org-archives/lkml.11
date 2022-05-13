Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49082C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 May 2022 20:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384387AbiEMUyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 May 2022 16:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384551AbiEMUyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 16:54:02 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A652E9E7
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:54:01 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-2ef5380669cso102215877b3.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QSjouBq1hkSPs3CGhNm0zY6/5FKoqgQOU3DpZD6z5pQ=;
        b=taQnrTu08fAuBevrb/1K2/eCT8Kgol6/wYE8edLu3Y81qXPvEvDctcBPceQwCKjH1a
         kDBsvDFXA5Dc3rkMd2Q2eOcLiKsdVM5dBox5U5OcgS+w0b9fLnM1W/r8X2vsna4jn6iD
         uDxRzug8JNRNYyWHGjPLDz8QYDYgZ69xBcHpMByu+I4XYpRj3JvqVRKnlvNga847KTsA
         /TICtVI7EQnOT4XBIMuCjWX+XOXhZdcdWjmG39F3zcVOBQM2qBnc6rgVKSrIzX4fBVa3
         wTXg/JUNNMWhz+W+nMOzxYI143vDymqBdJTPJeyzwVXQVZDG4axQFt1QWepPMishMUTm
         WMzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QSjouBq1hkSPs3CGhNm0zY6/5FKoqgQOU3DpZD6z5pQ=;
        b=wxjIu5heIUMRWRuQYKqWCbjbhWaQfdMfPYlU8rOlaqHkXFgUMxCOj0QFO14uZIkbL5
         RoOc2ihVpJRWp0Br3HO7NA9u6GAiADsk07pJkpzLxrz1Caq5YF6R582dGZk973na6IgL
         KmJsnYWNNo18uJsE7G0LvAAhWDxMy+HUhiJmyonIzjxkkCQwdguwJ94sMtddiABcpBhU
         QYhWoklhTutcSLMhdabcb92FBaCn1wN79oFGhM9P+GskdyqhLEWq6WUEkpEl+H3c3wEd
         IKBiqko69wtjetvo1e2nI3kNrZ3Ceh0cQ6Yi54cfMFbkJu4O9DaEaN9n/oqMe9VvSVOv
         qvvA==
X-Gm-Message-State: AOAM532wcrRz0YfJuslj2Yscnvfu0gtRPWOmCafjyHvOjFNOPcEUeJUC
        N4wB+7BuobqfvrOoa/JFCCw7kTeav8IYYcf3cB9ZhQ==
X-Google-Smtp-Source: ABdhPJyXFPMj0hfog8DqAA9Fv2desq61TfhzBIoyY59lAN9Gg0Drmja//xbzjuSnSd2hDwAwjCAVaLqHgYj7g7m3fTo=
X-Received: by 2002:a81:6d4f:0:b0:2fe:b911:fb6d with SMTP id
 i76-20020a816d4f000000b002feb911fb6dmr4421832ywc.140.1652475240413; Fri, 13
 May 2022 13:54:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220512175011.28753-1-dipenp@nvidia.com>
In-Reply-To: <20220512175011.28753-1-dipenp@nvidia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 13 May 2022 22:53:49 +0200
Message-ID: <CACRpkdb0nrQO_543KOeQsms=TtsmLNh2Waim_ko3wN4n890z2g@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Renamed hte directory to timestamp
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     thierry.reding@gmail.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 7:50 PM Dipen Patel <dipenp@nvidia.com> wrote:

> Renamed hte dt binding directory to timestamp according review comment.
> Addressed minor comment about having HTE acronym first in the common dt
> binding document.
>
> The change reflects above renaming in MAINTAINERS files too.
>
> Signed-off-by: Dipen Patel <dipenp@nvidia.com>
> ---
> This patch is on top of old series (Intro to Hardware timestamping
> engine V6) present in linux-next tentatively in preparation for
> merge.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
