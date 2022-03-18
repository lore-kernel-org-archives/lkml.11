Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DC6C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Mar 2022 20:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240657AbiCRUPq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Mar 2022 16:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240589AbiCRUPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 16:15:34 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7D324F2BA
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 13:13:58 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id bx44so6149910ljb.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 13:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version:organization
         :content-transfer-encoding;
        bh=+y0rwCe4nuqZXyGJW6zJlJSB/16NzNLv643jodotwEE=;
        b=hOwtfeqWxllX2RqL+hUCcnCh7zTR67FaxWoQjK/0ifLA6VPyWSTELe53uextZyeibx
         nCgsn6kYNqY6ty1KHmizKzdijp9f1Zuw4MzLG6d+bGEAYA/pumK0B30inAQNBDdvXFfB
         +ep3fxQx3ksuMusOMDhGZdUc0kgnGOeUeCIh/aMXWOyZdGb/bxftNKwYP3YBTfcmLdVw
         c+IVuWyYDgWl2B2qDYyqL5yFmujeJ0uSDIs4d8T9/c0srYn77tScauI919PooKXYFjUo
         ixBlnx9joxgJ1XZ+wmgA44dpqLqzEFxguTaYh/P+205AAQt8H4SfL6bNY2/rPHMilNvv
         mQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :organization:content-transfer-encoding;
        bh=+y0rwCe4nuqZXyGJW6zJlJSB/16NzNLv643jodotwEE=;
        b=Mz+0a6WMkr/cn4a7CfT/z6y6hE4e0mzSVG3LNPGHqksjz9jrQ0QRIWLOyt3ML1wHrm
         QfpT3sbxY5LcSGxt9Mscnz0l8pes7flGFRQhuaoGMtXyPes7wepqzNhqS7OEAlRqE4Gv
         CiEbdIPLlQ4AgPgVnPZZONP9kHjwdg1OSTRiKkkrSZu4Oz3q07/zt4qDjfc6ccqpmRUG
         nSCDvNAkIsXlacz5ck7pfspImzQZ5lxKtW2oFcJ6P+f1awdhtKg8D6JfS9KeYq7G3MZa
         vl8tPLzrkePiJOkadcVeKyeLsPtmsUXjNd73IJa1UxMbJkY7SYzVS9WNOmCbt+fGiH8v
         knnQ==
X-Gm-Message-State: AOAM531N+XPkgRcyrFUWirvxSUuoLlJLKG9SmJpRCzUMbW0hy+5XyGoc
        Y+Sh1eBBDERBLxFUrMkz0eXyRw==
X-Google-Smtp-Source: ABdhPJy1ax+pT0AYvkK+FK+Zo4b5g7HA5Fzx8rYZtpp1KaYPAWz3YUDP5bNPAgR9zBybulMELmBLEw==
X-Received: by 2002:a05:651c:1209:b0:244:546c:19a4 with SMTP id i9-20020a05651c120900b00244546c19a4mr7232491lja.396.1647634436823;
        Fri, 18 Mar 2022 13:13:56 -0700 (PDT)
Received: from veiron.westermo.com (static-193-12-47-89.cust.tele2.se. [193.12.47.89])
        by smtp.gmail.com with ESMTPSA id u6-20020a197906000000b00448a5b9d066sm981692lfc.189.2022.03.18.13.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 13:13:56 -0700 (PDT)
From:   Tobias Waldekranz <tobias@waldekranz.com>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     Marek Behun <kabel@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/2] net: dsa: mv88e6xxx: MST Fixes
Date:   Fri, 18 Mar 2022 21:13:19 +0100
Message-Id: <20220318201321.4010543-1-tobias@waldekranz.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Westermo
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1/2 fixes the issue reported by Marek here:

https://lore.kernel.org/netdev/20220318182817.5ade8ecd@dellmb/

2/2 adds a missing capability check to the new .vlan_msti_set
callback.

Tobias Waldekranz (2):
  net: dsa: mv88e6xxx: Require ops be implemented to claim STU support
  net: dsa: mv88e6xxx: Ensure STU support in VLAN MSTI callback

 drivers/net/dsa/mv88e6xxx/chip.c | 3 +++
 drivers/net/dsa/mv88e6xxx/chip.h | 4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

-- 
2.25.1

