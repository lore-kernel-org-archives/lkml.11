Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453C8C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 01:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbiDLBws (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Apr 2022 21:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiDLBwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 21:52:45 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEB1764B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 18:50:28 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id r25so4811312qtp.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 18:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jKyWVi0ve7aKsv/+aHfSEOINGe3jcF/vd8+tINhOMZE=;
        b=QSsOvOnZkV+2M7zbq6OC+bRcWNQYZT2UUt8v3cmf02LOAKcNqBgAxrIRUNKeSEEAoJ
         +wkEwO9wPlI6eJxxuzjKsaFYJtRrc99bkvNGGomxrGn4UoUTUCULgo/AGkPjjEXYDJoE
         EcBxoVBW5evfOEk/RGaPLtfxvAoRKdrq/3EpLOO8ukA6LEJJHuvUZEQRm+mlOEQeXCQD
         iK3mNjqrLYLOwOQCTNvnpfOhC9kMF6+XutcRcTY/YfWwJk4KxB6aZj0cvPLpKu+sUIdR
         Vz6j70xm/ZSrtGbR13um/c81eKjYHWveTjTATbAfg5/4lj75Oqwztj8PKRB5V1kZVfHZ
         28Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jKyWVi0ve7aKsv/+aHfSEOINGe3jcF/vd8+tINhOMZE=;
        b=xZ93xFgdWQiq1r0yhDO/QD+i4oMKOwLLdYhkg0O4Ug7iKgyPlpYCkC8+3Lvo9exVOy
         iONot/T+7WDhH0Hr9rmI4bvAC1/3hGC+WX29gRzgDBgkzq60Ie7oIejP6D8kNGE/09dS
         BMX55TvB39m0XA3mztDQ1QJCQs/vTAQIBfx9JTlWo5qIkAlWC9UK8EsMe/g1bWce8z0y
         40scClMQJmJNtw+Ld5ziw5sVZ7mFHTyEyh1MF64V1B7ayyawrudkbePYr+3/vHPld0Ju
         fdP7YNbQayPeCe8E2Uuuj7gQm3sEVvRSbIYJ/RwivgEjjvhDphLO6s9dQK1ZHOAktXfT
         q6HA==
X-Gm-Message-State: AOAM532SfT37zg9dEuuj//d+k0bq14N4E1xlYmoomuLLgwrf+6QVks0c
        ivUkEq26aGb3uHRiYbYuaaM=
X-Google-Smtp-Source: ABdhPJyEBMG97k4uEqBba5YXTdlj8fzZQ3go4vS1Au7uKyxdEVudkrcxMTbLa+Z0kDXvPaie3BSAfQ==
X-Received: by 2002:a05:622a:4014:b0:2ed:eb1:e12 with SMTP id cf20-20020a05622a401400b002ed0eb10e12mr1643843qtb.421.1649728227741;
        Mon, 11 Apr 2022 18:50:27 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme.lan ([2607:fb90:50fb:900e:25ab:983d:ac30:58b5])
        by smtp.gmail.com with ESMTPSA id s16-20020ac85cd0000000b002e1ed82f1e5sm29556305qta.75.2022.04.11.18.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 18:50:27 -0700 (PDT)
From:   Jaehee Park <jhpark1013@gmail.com>
To:     johan@kernel.org
Cc:     elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev,
        jhpark1013@gmail.com
Subject: [PATCH 0/2] staging: greybus: fix warnings reported by checkpatch
Date:   Mon, 11 Apr 2022 21:50:20 -0400
Message-Id: <cover.1649712572.git.jhpark1013@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch corrects a typo in a comment. The second patch fixes 
'void function return statements are not generally useful' warning.

Jaehee Park (2):
  staging: greybus: correct typo in comment 'Atleast' to 'At least'
  staging: greybus: remove return in an empty void function

 drivers/staging/greybus/arche-apb-ctrl.c | 2 +-
 drivers/staging/greybus/audio_codec.c    | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

-- 
2.25.1

