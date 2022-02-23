Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75512C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Feb 2022 22:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244652AbiBWWxc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Feb 2022 17:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240334AbiBWWx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 17:53:28 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E5C54F97
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 14:52:59 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id s5so601869oic.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 14:52:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6cjlh6Lgxb4Las2CramzzRGPafbG0QXdAHEx5gnPZqY=;
        b=P8cofCDbgyNss3qErMPfx5DczGvYg8nbrJm19LClcoISwOQzw5hZQeBeEKaVPxrdYx
         UxQ1kYDIU72LILlyOeY+XEkBN8M/NVgwjp0ar27GzAslBP3ZE7ZNMNVNy0y81yQNC5sA
         wAIvNiPTymC6jEo/1iDDVAYflLzwwuTSaFDjvD6R6TMzy3yi50l1hCFKJ+sc0v6rUE8m
         zoXGNNtxJM3clG1rGy74iikVxaLipa/UUhwhPSVjoVRgpyezD/awlSjcmABmXyieJhWe
         YwMeGni0TUbXke9nmXLzJ7V6f6u+FuJxOmEQ3S6A7ObMJJe28loGJ0bBqNRVOLkE9q+e
         wJrg==
X-Gm-Message-State: AOAM5329VLIHjNi/VHoEuryk1X+dI3FjLMH0Cpi/SloOYXyYfOdFuiDL
        y1xz7iP7stRJMgbngl1gGJ8dL0ELHQ==
X-Google-Smtp-Source: ABdhPJz+AbHJ4R29gBfL5l/TI4AIRIK5uBcA4g3gMzjOxTjiRsWSyvdqB2R8oA8IfbpU7ppO2JVF2A==
X-Received: by 2002:aca:61c3:0:b0:2ce:6ee7:2cc7 with SMTP id v186-20020aca61c3000000b002ce6ee72cc7mr5442886oib.245.1645656779287;
        Wed, 23 Feb 2022 14:52:59 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id y15sm398775oof.37.2022.02.23.14.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 14:52:58 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] driver core: Refactor device unbind/probe fail clean-ups
Date:   Wed, 23 Feb 2022 16:52:55 -0600
Message-Id: <20220223225257.1681968-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The same sequences of device clean-up code are duplicated 3 times.
Changes to this code are prone to missing one of the copies. This
series refactors the code into 2 common functions as there's some slight
differences in the intermediate steps.

Rob

Rob Herring (2):
  driver core: Refactor multiple copies of device cleanup
  driver core: Refactor sysfs and drv/bus remove hooks

 drivers/base/dd.c | 80 ++++++++++++++++++-----------------------------
 1 file changed, 30 insertions(+), 50 deletions(-)

-- 
2.32.0

