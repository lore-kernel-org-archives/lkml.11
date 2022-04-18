Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD37C433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Apr 2022 14:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344954AbiDROX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Apr 2022 10:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245291AbiDROLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 10:11:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA9D2DAA9;
        Mon, 18 Apr 2022 06:10:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F2AEB80E59;
        Mon, 18 Apr 2022 13:10:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0014C385A1;
        Mon, 18 Apr 2022 13:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650287456;
        bh=xhvIWY/y+K/Jp8CbeirncBkrErNBEIQWyRtfWMm0irA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=igxuRBxRkYP4cJu56SfckZxrpUyJVWt7Gp/I8CWlNOulNTNPIBq68ocK/wYwQpWFK
         riGBavyUV3K72BV61J5spiKr7b3h108qw6oRDQSJGsfb05zvMpchE0D1rspRT9Zopl
         Hve0196sdz2UBz8q/SzhZPKIkOhhddkPlPChDk30=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 127/218] ACPICA: Avoid walking the ACPI Namespace if it is not there
Date:   Mon, 18 Apr 2022 14:13:13 +0200
Message-Id: <20220418121203.224701137@linuxfoundation.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220418121158.636999985@linuxfoundation.org>
References: <20220418121158.636999985@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

[ Upstream commit 0c9992315e738e7d6e927ef36839a466b080dba6 ]

ACPICA commit b1c3656ef4950098e530be68d4b589584f06cddc

Prevent acpi_ns_walk_namespace() from crashing when called with
start_node equal to ACPI_ROOT_OBJECT if the Namespace has not been
instantiated yet and acpi_gbl_root_node is NULL.

For instance, this can happen if the kernel is run with "acpi=off"
in the command line.

Link: https://github.com/acpica/acpica/commit/b1c3656ef4950098e530be68d4b589584f06cddc
Link: https://lore.kernel.org/linux-acpi/CAJZ5v0hJWW_vZ3wwajE7xT38aWjY7cZyvqMJpXHzUL98-SiCVQ@mail.gmail.com/
Reported-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/acpica/nswalk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/acpica/nswalk.c b/drivers/acpi/acpica/nswalk.c
index ebd731fe8e45..6902c2a01f6f 100644
--- a/drivers/acpi/acpica/nswalk.c
+++ b/drivers/acpi/acpica/nswalk.c
@@ -203,6 +203,9 @@ acpi_ns_walk_namespace(acpi_object_type type,
 
 	if (start_node == ACPI_ROOT_OBJECT) {
 		start_node = acpi_gbl_root_node;
+		if (!start_node) {
+			return_ACPI_STATUS(AE_NO_NAMESPACE);
+		}
 	}
 
 	/* Null child means "get first node" */
-- 
2.34.1



