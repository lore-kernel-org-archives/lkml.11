Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C859FC19F29
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Aug 2022 06:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239424AbiHFGjm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Aug 2022 02:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiHFGjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 02:39:40 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F0DCE04
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 23:39:39 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id z12so5332174wrs.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 23:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=qvVrHjdyOQqTKVPm+ffdIWH8fMJq901sk0t71M0qVAY=;
        b=aHBKYYkJGnhfqRts2gES+farJB7y/fKflTfN9tQKH1u7MGF1dTjYepvUlGsOw6Pyp0
         fatwD9xjO1lhWbm6Pmz1UDm+PALTC+gp/iux9L0RFqU0CgHeZWewl1pohsp34FyEpulC
         BVM2ZR8dibNZAaYIahCS2V3cVYrkcU6XmlVD6zFTpdTwEu/jTJD+8/QaCKklpz4cAhth
         9NBpobcZHvLnejXvH1kgPYOb+J8bB8WylNNceHqxo/gagAUXz3+pD64mUxYpPRLPETE7
         Y7gSsRHrKmyYBpwxrwLeVE1KRYFG/cgnfysXmkEk7QRqyFUZCz2lnR9VtctW8HkGoAUl
         mUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=qvVrHjdyOQqTKVPm+ffdIWH8fMJq901sk0t71M0qVAY=;
        b=IzWI+XcYOHFDWixvONCgsLa/gJwS9deEduuzQ2W5vuTmPxLTexlOySg2ZLBp7t6rhr
         3sW0NAoGolcd1uJllDSAayzyESApWCDfC9qvZ2dWGE2XH+FC+9ugPKH5H2Hu05QzGt3A
         bCSTvk/Di742j9LXP48WS7yr+A88FW4bA1SdB6xFmlgTWRhI3Uf/5OCexJS8MpjLqN9+
         TCg9RM3aAmRHjTiFUhXKBwOOqabHI0zR8H7PJa/lSb4d+XCSB6x4ToTZZNbVKtogavCC
         HRBDNK3e2ZoxeowikFflLy6IK3poWfJA1F84poghcNSbi4T6BeHpfHHCeIL2LkOywcdk
         HSwA==
X-Gm-Message-State: ACgBeo3QYz5cwzizsHgkArOA7RRZBnQALYYW3cgAH6Mk+dxFZL3so9RQ
        4z8dZ4algIznkxqoemo0NLoWnWtHhIbJ+w3OCgu0HCU3
X-Google-Smtp-Source: AA6agR4lDUnO5LVALMFzzAYKapZV/0CzWfW1KmQJez6PRp7GsA2T9kIT4Ux/8H11BUEYkHS0wTMAwu71R98/lhL6iOk=
X-Received: by 2002:a5d:63c9:0:b0:220:68e1:7f3f with SMTP id
 c9-20020a5d63c9000000b0022068e17f3fmr6185500wrw.134.1659767978267; Fri, 05
 Aug 2022 23:39:38 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?SWxhcmkgSsOkw6Rza2Vsw6RpbmVu?= <ijaaskelaimen@gmail.com>
Date:   Sat, 6 Aug 2022 09:39:26 +0300
Message-ID: <CAJ0SC_DVbvqgJs8wZ8Kb1i3bGsVYPP+s4b=jyXsyt5SWPTQNSQ@mail.gmail.com>
Subject: linux-4.9.x fails to build with coreutils-9.1's cat-9.1.
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regards, zf.
