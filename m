Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DD0C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jun 2022 19:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239283AbiF0TYl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 15:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238212AbiF0TYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 15:24:39 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788B364FB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 12:24:38 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j2-20020a2597c2000000b0064b3e54191aso9127873ybo.20
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 12:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ZpCJc2rc+sYEsINFmbTJgIGX3M8ULd5VrOvh1A/XaEY=;
        b=o67FEwKgVdk3Zy3r+YQ3Y0NJjwoA7AeiHmM8w/rtogHpAQ2mj02lHbVNs/JxZ4hpBj
         T/a5hBp22eWioSgyBSm56NASweHOepeBdDXw1gRjAuSCqVot42G8bxBhYJUYBc2hd9rF
         9ByvA7quvMvsmuZ7RVaFGS0dGPgYm4zbWo1ddIHc3dppYBwG0aRldn7gCo9u7TlWJrLP
         8oafZ7Kl6ctwZdaAUKtHzphCiR8c2wzpV4mMtymgdW92AGjwxZOtUt0aQ9fWm9MnHwEc
         DH089BEdd2g5UO5FA4261RKIZWEzm4Xu25VFRzgo9q8X5IB/SQhouK2s6YUq8elKapyh
         4SlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ZpCJc2rc+sYEsINFmbTJgIGX3M8ULd5VrOvh1A/XaEY=;
        b=armneDEn/ClNsWeip8zZoIyiM+CandQ6hjvKZu9naBUKvFW/qufOVfL1KDV86IOkiy
         o7FSQoYO1bOgP8GIMo9vPExWwOyZ4Mb4X/a4hRA3YGI0QXSooQ1bsBpZUfBNLBhfub10
         3aXrf1epa+S/EcAWYTXq94Iu7XYgoNYv6QtNx0BQMlHJu8xgYIZ9ARktJYfVNt/kLCuz
         /JyR/wSAwSg+mOzXWfjfHlr7tbhG7SA+z575u8Kbfq1YHIMizDu8DPEpR1nQp7rSwEDg
         E7Y5+bBQ1uhsa2jxMtpsfS6V7qpiTLz89nn1rCGgj6hzPKb0zb64k8wKtKAzLTBhOoeQ
         OXXg==
X-Gm-Message-State: AJIora8vivEMl7PzPp86oMprybn4KukoYNqENrGhCQ4fi3ek2ODHcZj+
        g7umQk4N/D6EfsCHdyjf7ouaZxZuylqphA==
X-Google-Smtp-Source: AGRyM1u90sIWmm9RL7pZS9+DxgYi3F+jtHNXu6v51nIOrGDUgbkclS3dzhjjN4ZqGGmUvLRlrwjF7EpZIkMxxA==
X-Received: from zllamas.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:4c])
 (user=cmllamas job=sendgmr) by 2002:a25:5092:0:b0:66c:810c:e520 with SMTP id
 e140-20020a255092000000b0066c810ce520mr15120580ybb.649.1656357877795; Mon, 27
 Jun 2022 12:24:37 -0700 (PDT)
Date:   Mon, 27 Jun 2022 19:24:34 +0000
Message-Id: <20220627192434.2306065-1-cmllamas@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH] MAINTAINERS: update Android driver maintainers
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Carlos Llamas <cmllamas@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've been contributing patches for binder{,fs} targeting fixes as well
as new functionality. I've also helped reviewing some of the incoming
changes. As such I'd like to be added to the maintainers list for the
Android drivers. Note I'm also dropping Hridya's name from the list as
she has now moved to a different role.

Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe5daf141501..468cdf150215 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1329,7 +1329,7 @@ M:	Todd Kjos <tkjos@android.com>
 M:	Martijn Coenen <maco@android.com>
 M:	Joel Fernandes <joel@joelfernandes.org>
 M:	Christian Brauner <christian@brauner.io>
-M:	Hridya Valsaraju <hridya@google.com>
+M:	Carlos Llamas <cmllamas@gmail.com>
 M:	Suren Baghdasaryan <surenb@google.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
-- 
2.37.0.rc0.161.g10f37bed90-goog

