Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D882C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 May 2022 03:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbiERDSw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 May 2022 23:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiERDSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 23:18:50 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7616350A;
        Tue, 17 May 2022 20:18:47 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id h186so983566pgc.3;
        Tue, 17 May 2022 20:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tMAxzb24R3EAgdCoByrXUsyskdjkX6iml5lGT/yCvxg=;
        b=KLNPxYDBH8bErvt5WCiy8QigVuHxQ9ZvQRy/2qaZTYhxVlYVKXqsUoy8iYJDYrphdo
         0Om9c63t/u8f0WS1Bh4hlxm8KKsoDVT5bAaUQtAJIdXpKC2sjkMeyftLH1R68PqZK9q2
         asrflTECM7Dq7yf/gNZFxkizoyXFET9TFBBhsStDXwKiMyyvHVCIAxIhN2a7QN1WxoOl
         A4bo6TbCVO1isDh8+3CXsorTChGlze3YHoGitQJohLvHkMPftI++2KKQ6G3o02FVj8kI
         GUjEwB1sQVdqfXRc8pJPKJFfIglp3fQ3Q4+TlqLt0GDLhPnFugsq2nYdk09SwyqED1tK
         lTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tMAxzb24R3EAgdCoByrXUsyskdjkX6iml5lGT/yCvxg=;
        b=6sNAW1mwiv2u4VHZK45hsv3rrKic+zMLkkiJXs41XmOznzRtb9b0pZ+VYWH7agLPaB
         wOGk4KFF4ODxEMBPqnCAYLk7Vrd4aHlnvaLd0CZpGW0xFbOFjNf8IGhlk/vGg+Q37lTy
         s4mWXxhnNQwFa3y9+skC8HQYkrKALW0rfMfUiWovSo5mQgMuFgi5wkXk1mz0uTAaDuU2
         m08EogKed8i60L9N0lvEnc4D/xteMJK9YXY1q1jJu/wvhIXACSFCNdJkFIroD5iy8/Mp
         8qmn5jJf9mdam+TU64aUfjxhJMEqLevIZLsI7Mw8ySx+0ISzs+p1hxu0AeNegrO/2trH
         7jMg==
X-Gm-Message-State: AOAM532JfWCJIuhUlzZpevrDGX/QplT5Etnz1Z0bKGww7DVLpj5Pz/p5
        XTdL3pbeiOcYhWcambpUY6mliQ/jPQA=
X-Google-Smtp-Source: ABdhPJwinRewQ2jdu13XNrCns1zq6XrjNttpeqneVDwUZ6fQ4OO680R98u+8jasWzz75zk/tVTa9CA==
X-Received: by 2002:a65:6c12:0:b0:3db:a518:ff1b with SMTP id y18-20020a656c12000000b003dba518ff1bmr19269248pgu.315.1652843926724;
        Tue, 17 May 2022 20:18:46 -0700 (PDT)
Received: from debian.me (subs28-116-206-12-63.three.co.id. [116.206.12.63])
        by smtp.gmail.com with ESMTPSA id b12-20020a170902650c00b00161ac982b9esm343771plk.185.2022.05.17.20.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 20:18:45 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Benson Leung <bleung@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: [PATCH 0/2] platform/chrome: Documentation update for Chrome OS ACPI
Date:   Wed, 18 May 2022 10:17:49 +0700
Message-Id: <20220518031750.21923-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two documentation patches touching Chrome OS ACPI sysfs.

  1. Patch [1/2] fixes htmldocs warning reported in linux-next and should
     be merged before upcoming merge window.
  2. Patch [2/2] rewrites symbol descriptions to use imperative mood. It
     can be merged when appropriate, independent of previous patch
     above.

Cc: Benson Leung <bleung@google.com>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>

Bagas Sanjaya (2):
  platform/chrome: Use tables for values lists of ChromeOS ACPI sysfs
    ABI
  platform/chrome: Use imperative mood for ChromeOS ACPI sysfs ABI
    descriptions

 .../ABI/testing/sysfs-driver-chromeos-acpi    | 113 ++++++++++--------
 1 file changed, 62 insertions(+), 51 deletions(-)


base-commit: 0a4cad9c11ad46662ede48d94f08ecb7cd9f6916
-- 
An old man doll... just what I always wanted! - Clara

