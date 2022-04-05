Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53544C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 08:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235741AbiDEIkX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 04:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbiDEH7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 03:59:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129A654BD6;
        Tue,  5 Apr 2022 00:53:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD59CB81A32;
        Tue,  5 Apr 2022 07:53:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A252C340EE;
        Tue,  5 Apr 2022 07:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649145206;
        bh=6/cQjaXqq6vyOdwI/I7vG3d/NAXAZj9v3wIcWjLZh04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a6QAf1iIPl5avnxNFi5kzuBZ/vELNDk9wzIqHElQOXji2FiwGAzW+l6iMSeXVh69V
         OifnVep1deg2yBH5i4J54/9/DZMDz2lAO7mOM3xf+BO4FgHYMEt+Lg/mzy2YPYU2ze
         AXehbpy9v8KwmLiU+jcdyfPXkWSi1ZMbxAMykUgQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Alejandro Tafalla <atafalla@dnyon.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.17 0323/1126] ASoC: max98927: add missing header file
Date:   Tue,  5 Apr 2022 09:17:50 +0200
Message-Id: <20220405070417.098371956@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070407.513532867@linuxfoundation.org>
References: <20220405070407.513532867@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit bb45f689fa62110c263c86070bfcb9ecbb6e1e23 ]

Add a header file that provides the missing function prototypes
and macro to fix these build errors (seen on arch/alpha/):

../sound/soc/codecs/max98927.c: In function 'max98927_i2c_probe':
../sound/soc/codecs/max98927.c:902:19: error: implicit declaration of function 'devm_gpiod_get_optional'; did you mean 'devm_regulator_get_optional'? [-Werror=implicit-function-declaration]
  902 |                 = devm_gpiod_get_optional(&i2c->dev, "reset", GPIOD_OUT_HIGH);
      |                   ^~~~~~~~~~~~~~~~~~~~~~~
../sound/soc/codecs/max98927.c:902:63: error: 'GPIOD_OUT_HIGH' undeclared (first use in this function); did you mean 'GPIOF_INIT_HIGH'?
  902 |                 = devm_gpiod_get_optional(&i2c->dev, "reset", GPIOD_OUT_HIGH);
      |                                                               ^~~~~~~~~~~~~~
../sound/soc/codecs/max98927.c:909:17: error: implicit declaration of function 'gpiod_set_value_cansleep'; did you mean 'gpio_set_value_cansleep'? [-Werror=implicit-function-declaration]
  909 |                 gpiod_set_value_cansleep(max98927->reset_gpio, 0);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~

Fixes: 4d67dc1998f1 ("ASoC: max98927: Handle reset gpio when probing i2c")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Alejandro Tafalla <atafalla@dnyon.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Link: https://lore.kernel.org/r/20220129080259.19964-1-rdunlap@infradead.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/max98927.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/max98927.c b/sound/soc/codecs/max98927.c
index 5ba5f876eab8..fd84780bf689 100644
--- a/sound/soc/codecs/max98927.c
+++ b/sound/soc/codecs/max98927.c
@@ -16,6 +16,7 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/of_gpio.h>
 #include <sound/tlv.h>
 #include "max98927.h"
-- 
2.34.1



