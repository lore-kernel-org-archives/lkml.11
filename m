Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF2FCCA488
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jun 2022 11:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239995AbiF0L6g (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 07:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238623AbiF0Lv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 07:51:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6EE7660;
        Mon, 27 Jun 2022 04:44:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D141B80D37;
        Mon, 27 Jun 2022 11:44:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5065C3411D;
        Mon, 27 Jun 2022 11:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656330292;
        bh=prAZB8L5jCOXRzpnKNMD8lRNgmHpfgzOwrR98cT5clo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ENUEP4Ec/lALyVNOCJpkF8eaO5tHFKrdnErJkGiTD1Y4rd6+JfMlic+7oxfG9zXy1
         5Ln4kFSDad6f26//3BH8HKg9vooqwOqFB6UGRg8Pr799FMhfwVDBVw7la1CLf2VdTH
         dsKJLixMX00Ew5GZJBu4OdGRi0FRWh/KzHgi0H54=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.18 149/181] iio: adc: adi-axi-adc: Fix refcount leak in adi_axi_adc_attach_client
Date:   Mon, 27 Jun 2022 13:22:02 +0200
Message-Id: <20220627111949.005101165@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220627111944.553492442@linuxfoundation.org>
References: <20220627111944.553492442@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaoqian Lin <linmq006@gmail.com>

commit ada7b0c0dedafd7d059115adf49e48acba3153a8 upstream.

of_parse_phandle() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: ef04070692a2 ("iio: adc: adi-axi-adc: add support for AXI ADC IP core")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Link: https://lore.kernel.org/r/20220524074517.45268-1-linmq006@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/adc/adi-axi-adc.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -322,16 +322,19 @@ static struct adi_axi_adc_client *adi_ax
 
 		if (!try_module_get(cl->dev->driver->owner)) {
 			mutex_unlock(&registered_clients_lock);
+			of_node_put(cln);
 			return ERR_PTR(-ENODEV);
 		}
 
 		get_device(cl->dev);
 		cl->info = info;
 		mutex_unlock(&registered_clients_lock);
+		of_node_put(cln);
 		return cl;
 	}
 
 	mutex_unlock(&registered_clients_lock);
+	of_node_put(cln);
 
 	return ERR_PTR(-EPROBE_DEFER);
 }


