Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03D2C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 May 2022 18:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357676AbiELSho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 May 2022 14:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236560AbiELShl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 14:37:41 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3436949B
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 11:37:40 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id i19so11897980eja.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 11:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=llEoX+p/O6HR36Ljgn5NZ7PhsoLdAcO1wdmtCWdau7g=;
        b=GWYIpBLPjk3riEZxwMpIDYkFGs7dudx59bqS5MYiUhPdqqxKzzIlgXrIfotpgYkiOX
         BZxjfCoxnp7YzyxVh+yhk4lj7jvDrrHCJ5NMPiwh1pskbQd5bgfBOy6AewOr0M4OdbgX
         KUGVM21PAEUZK+Vp605oKDgY4lgGckHAUwQRRFwwbyfveKlk48rhK5LDncAsYrpWKLoZ
         qmi6BkwKypyNgFuBA+q97132Qx3obxmbHKhzJ4KnqpMLLUficrvw6z4Vger/GRJEWXDn
         hC9+yh9JWEbmwC6Wx7/jHo/3hidA0DtTN4PhMUuQGZmBK6iKHqzVCX/4xluzXBJY7395
         i1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=llEoX+p/O6HR36Ljgn5NZ7PhsoLdAcO1wdmtCWdau7g=;
        b=3objDOrm0HpK8NE9v/xPiqLgZO/6XYlHWMHHPSGWq08+iRDS6JtPRR2VS/PH+pq4br
         foXZbUFX2DBCLU2rflyr2mTg8lQ4alEqYPoHKzNmjPZUfvLGXTHPQEp4NOBZMBT7JaOd
         s+rv2m6gKsn3hLRBQdjDEMMpCp+3+EwOo9c+Xi/YujImNXSZNYvSrRKXHgzErz8x0wtD
         NkDIaHv/7fUSDqCsf3ALOiU8+6Mwrl1TIKX5UWdVg/IK5Ut2HmDDBmk24hlGTm8LtnjP
         NARDGcEKJ7doyZG1jr6CEtqyDJC7olfVz/Lon1+3YWaeQOZHXJDB3IvLqbZYATbnQfQZ
         phMg==
X-Gm-Message-State: AOAM533qa75h7EOZbpLlpw2g9oNpUBX2p4WLc+E2MfQfHil7469PfDrf
        HXQ7n+gbvXqd6Mx0IcGXPSvb8MEdcQ02ZDRKJsJX1g==
X-Google-Smtp-Source: ABdhPJzHo4KdWRRPsWLy4avgwSNbcyEMs350bXnr/6GJseCP3F4Ws/i4Z8r8+0XnLpYcC/1Qa2kNdVM0M6ApRaCJgZE=
X-Received: by 2002:a17:907:6d0a:b0:6f9:b861:82b8 with SMTP id
 sa10-20020a1709076d0a00b006f9b86182b8mr1124352ejc.478.1652380659345; Thu, 12
 May 2022 11:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220509204909.2464496-1-dlatypov@google.com>
In-Reply-To: <20220509204909.2464496-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 12 May 2022 14:37:27 -0400
Message-ID: <CAFd5g45RCw5S4MSSerqtxWz9kkaf9K1+GwT-2_aD6jB4oGfMOA@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: misc cleanups
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 9, 2022 at 4:49 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> This primarily comes from running pylint over kunit tool code and
> ignoring some warnings we don't care about.
> If we ever got a fully clean setup, we could add this to run_checks.py,
> but we're not there yet.
>
> Fix things like
> * Drop unused imports
> * check `is None`, not `== None` (see PEP 8)
> * remove redundant parens around returns
> * remove redundant `else` / convert `elif` to `if` where appropriate
> * rename make_arch_qemuconfig() param to base_kunitconfig (this is the
>   name used in the subclass, and it's a better one)
> * kunit_tool_test: check the exit code for SystemExit (could be 0)
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
