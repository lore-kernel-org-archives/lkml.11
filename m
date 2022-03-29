Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DBAC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Mar 2022 21:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbiC2V3V (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Mar 2022 17:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234087AbiC2V3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 17:29:19 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BB4239306
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 14:27:35 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id h4so14407025edr.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 14:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x5Kf4tIOrW+TXVLfToUnNnc77oMmkd7cGdwQs3kzn5E=;
        b=Q3rNjLjzz3gs978QUv6jP8uCoY3jVNFRY6pnshB6MtmFG7vA2Sit1U7E5MPSfa+Rk0
         PErHcuDYc+mDXNrdrGyszuN/0nv0rvy09XmBqsXB/DHm2IZuXJ8mPtXBgkBehaqEWEYG
         v+yBtAMI+fTI1jRF+prEPRxTl0p1KNh94oJR9EV/+L1uYi5tK+3jpNcIIHLzqdgPr7CN
         74ClmqXbHJ/6wmIWI4aPsMGSc5zEGoyPIMHa1cj9j1r98GjRjR8/x2ol1P3hXRPcrkaL
         GOvpeCZ42Vvca2n0XnRINkbQSgiJd1Ure4ABlhBUbklR+ZgCr3Om3sP/7mW7UsGZUqWT
         zs7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x5Kf4tIOrW+TXVLfToUnNnc77oMmkd7cGdwQs3kzn5E=;
        b=TZ482Y/AcCLtdU7LAn1bYDtaoxXNUbhTL002IfSzFzy4dFWJXt6gsgmMiKI6n3YuPM
         C2kWDlg5DlEjLwRQIbmFVFfHUipLEHJelI9CjaWvFHdcVvfKsf63V1Jdl+ir+iViu6ir
         Kmux7PFHPJ0bIK9w5FtelixtJSm0KOI6BOHXy4scl6sExE/eqjDc9bxBEV9pCZ0YUHs2
         y8NIktmioLfZBJ3iXxuC4Q6yJkFcme7vxgPKSKreAFiBt59mG9PvKLO4eM4Nyro8lYCy
         YYJt0zYILkgbeJ0ZrMeY9WoRcp8ADtWj/PG78nAxfBgu2PhMBrlPwjAyMkABTUwz3OaG
         IwQg==
X-Gm-Message-State: AOAM533YXih+GJj41fYyHSzMfXo3xKZhFPxIwSF4WehCXHGSNhPk0uh6
        Wm/CBCmdvrHJVj0WaLffi9N+J6HQeOugIJZqUXaOvQ==
X-Google-Smtp-Source: ABdhPJxLl4nDWjhDn9MDxFoq2paLjPe4jmT3iGnfqwDbvQcl0/wz7iO0WhBwZrKB8nf8+weeT8q+yjqELi4kBzuJ8+s=
X-Received: by 2002:a05:6402:1cc1:b0:413:2b12:fc49 with SMTP id
 ds1-20020a0564021cc100b004132b12fc49mr7190427edb.118.1648589253782; Tue, 29
 Mar 2022 14:27:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220131212341.1082577-1-dlatypov@google.com>
In-Reply-To: <20220131212341.1082577-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 29 Mar 2022 17:27:22 -0400
Message-ID: <CAFd5g46z_RBMWRTfJB5h_sdkaEaJCOwnnkUER0fPSPQ6ac5_6A@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: kunit: fix path to .kunitconfig in start.rst
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, Yifan Yuan <alpc_metic@live.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 4:23 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Commit ddbd60c779b4 ("kunit: use --build_dir=.kunit as default") changed
> the default --build_dir, which had the side effect of making
> `.kunitconfig` move to `.kunit/.kunitconfig`.
>
> However, the first few lines of kunit/start.rst never got updated, oops.
>
> Fix this by telling people to run kunit.py first, which will
> automatically generate the .kunit directory and .kunitconfig file, and
> then edit the file manually as desired.
>
> Reported-by: Yifan Yuan <alpc_metic@live.com>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
