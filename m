Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA163C43334
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jun 2022 08:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbiF2ISQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jun 2022 04:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiF2ISO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 04:18:14 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E436360;
        Wed, 29 Jun 2022 01:18:13 -0700 (PDT)
Date:   Wed, 29 Jun 2022 08:18:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1656490689; x=1656749889;
        bh=deP7GyXC9ZxqfXEwFpsGYTw5aRq5KASPRxGk3xoBFW0=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:Feedback-ID:From:To:
         Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID;
        b=X340piRB8ju8NyA3rXUUUfd5isroFkdGe9CndDe6KCMKho9Aw/iVxdsmEL9ViEyqR
         y7Skte++X7O0cjcgDE+FTxYx/BQy9ZaHQf57DSrWFSCAsK5r/akUxlRId7O4UVfbg2
         Fa7QAYqrlkOUST/yMP7nfkk8AKVhS8aelHiFiavTCokC9QnX7Gedj3Mrt8wrPwJcMp
         F28RVx9WRurUj2bI9acKcLBola59rNK3uNtlhXnN4lPq5TYDxxZKC5pJd4uafEXvRi
         bBLBc3lwn3ogTC/HHcaMbC4C5CFd+10lvRuRb1Jcs4zIrhmqM3oU8G4F96eKLzhl1E
         2EHPAEiDFIMmA==
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Jari Ruusu <jariruusu@protonmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>
Reply-To: Jari Ruusu <jariruusu@protonmail.com>
Subject: linux-5.10.127 modpost warning
Message-ID: <B9ViOjUL7reNao5fkvKkt4S91RPpLSuY6lGtyNIFW4WCgET8Z5Y_9-Y7O1GuZJ9FJFk7QouCfASA1ogdd-xaSVQNtR9RN2r2kFD7zu9vbMw=@protonmail.com>
Feedback-ID: 22639318:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This shows up when building linux-5.10.127

  LD      vmlinux.o
  MODPOST vmlinux.symvers
WARNING: modpost: vmlinux.o(___ksymtab+drm_fb_helper_modinit+0x0): Section =
mismatch in reference from the variable __ksymtab_drm_fb_helper_modinit to =
the function .init.text:drm_fb_helper_modinit()
The symbol drm_fb_helper_modinit is exported and annotated __init
Fix this by removing the __init annotation of drm_fb_helper_modinit or drop=
 the export.

--
Jari Ruusu=C2=A0 4096R/8132F189 12D6 4C3A DCDA 0AA4 27BD=C2=A0 ACDF F073 3C=
80 8132 F189

