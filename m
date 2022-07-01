Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0F1C43334
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Jul 2022 01:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiGABlr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jun 2022 21:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiGABlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 21:41:46 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EE15C976
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 18:41:45 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id v38so1570734ybi.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 18:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=HJTBmxBGW9W4199hpEMcdLCwjZ11aqurlY/x4u4Dwvc=;
        b=AGcyD1IX+NHLLAMUmijwjR3pSiV3Rc9/MysH1D+kU9mpVIi5wmAEDb9fEPgSG8ggNq
         tPxegdPFpaGLbDZ0K9+ypsLNq7UPoH6q4293byk3cW49Yp5FOH3ahRfe/HBLQmQgNYR6
         vB6gT8dfPR8pV58FM3jyj2JhJPzfziMPDE8BlzD9mQyQB4tMCj+TEciCKjcyhbkSBbFN
         LzTx4I0psCcTauyLBzihPoaCC9r3MfCLl68o5jLegjyCH0FZ2ujFeQruFNDdAWEkZCG0
         pUZCBMTi2+PBoqzwVWW+zUC+aNVPAZWuQ0Wa1N+JSZpb/Mz2i/aQnm6j6hNnkBnQFOvG
         1TFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=HJTBmxBGW9W4199hpEMcdLCwjZ11aqurlY/x4u4Dwvc=;
        b=vzw+cUevzyqv+vMGGLeg+ZBgLL8lzHStsEFqq5Dihhw+YWGExVW5IY9HHMB8x55sE6
         GjxmoC2aDGl8kEFF3zSdOfsdON86tj6zNwcPN1m+t5F751YiqEAL3eUzhcGT05FHKy/L
         qjhqAm1ZfaaYo5BIpjzwifI+2NnbqszB0kOz8KaYSKM5gzLwOCFQHSiD6FW8D7abrBTu
         /2qTzwabwSVL9DcOcjTvpS4wxfszbWtuQCe9h7DtD+++Xccz3vJg3kU/g2nn6HrQi07R
         x2E6csX+oXlCrFXazgJsxgfLvGRkxOMKTYov9hgF1wAnYL4RpazOyL3PaYt4st6FaG8f
         iuaQ==
X-Gm-Message-State: AJIora+fEGqkafAhkdQ1mxfNLTYIh5eGh9f6FwnaZmJ5sGcPOLaxhNIr
        ICh40+a+eKkHa5wyZ4YTeUp0vrcqSxFepFcjlrMLRw==
X-Google-Smtp-Source: AGRyM1s+QD+jnm2v7T4uugIZJLuhzBqHa9ZHhbBDagzlcxMyDnN17zRnoQXd9hcwKx+BG0lCa1Vq+it8Lhmtnz2PxpE=
X-Received: by 2002:a25:9947:0:b0:663:ec43:61eb with SMTP id
 n7-20020a259947000000b00663ec4361ebmr12613397ybo.115.1656639704712; Thu, 30
 Jun 2022 18:41:44 -0700 (PDT)
MIME-Version: 1.0
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 30 Jun 2022 18:41:08 -0700
Message-ID: <CAGETcx_vVe7c2BgRcuHHNFn7ZR5_Fx3B+Bv1mdp6EWa5kfKLKg@mail.gmail.com>
Subject: Peter's email address in MAINTAINERS is bouncing
To:     Peter Korsgaard <peter@korsgaard.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Peter,

You seem to have multiple email addresses in MAINTAINERS. The
jacmet@sunsite.dk address is bouncing. Can you update your email
addresses if they aren't up to date please?

Greg/Linus,

Ccing you because it's not clear who maintains the MAINTAINERS.

Thanks,
Saravana
