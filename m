Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8981EC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Apr 2022 14:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343970AbiDROWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Apr 2022 10:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245300AbiDROGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 10:06:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DE735DF3;
        Mon, 18 Apr 2022 06:10:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 370EC60F26;
        Mon, 18 Apr 2022 13:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C256C385A1;
        Mon, 18 Apr 2022 13:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650287417;
        bh=l/Gdx++pz+V6U6adauuivIXOSovZ3uz7GOa+1ZsCrKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qxct//4XhB+Au6Xd4T5tKUmCQs/KftQhGZ1tYHhbISkYNWWm7GI0IdjiLFDu/fHbU
         K1HtWO1E+u10MUhmhAog3jg+jQ5xt7rzMUUCa409NPNPCrwF0dJzBqNVPYAUqxZ/8j
         1oUaBRq2Ee4qE84ApVmkRFxV406k+P1cZ04EUXrw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kernel test robot <oliver.sang@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Huang Rui <ray.huang@amd.com>
Subject: [PATCH 4.9 154/218] ACPI: CPPC: Avoid out of bounds access when parsing _CPC data
Date:   Mon, 18 Apr 2022 14:13:40 +0200
Message-Id: <20220418121204.325433580@linuxfoundation.org>
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

commit 40d8abf364bcab23bc715a9221a3c8623956257b upstream.

If the NumEntries field in the _CPC return package is less than 2, do
not attempt to access the "Revision" element of that package, because
it may not be present then.

Fixes: 337aadff8e45 ("ACPI: Introduce CPU performance controls using CPPC")
BugLink: https://lore.kernel.org/lkml/20220322143534.GC32582@xsang-OptiPlex-9020/
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/cppc_acpi.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -681,6 +681,11 @@ int acpi_cppc_processor_probe(struct acp
 	cpc_obj = &out_obj->package.elements[0];
 	if (cpc_obj->type == ACPI_TYPE_INTEGER)	{
 		num_ent = cpc_obj->integer.value;
+		if (num_ent <= 1) {
+			pr_debug("Unexpected _CPC NumEntries value (%d) for CPU:%d\n",
+				 num_ent, pr->id);
+			goto out_free;
+		}
 	} else {
 		pr_debug("Unexpected entry type(%d) for NumEntries\n",
 				cpc_obj->type);


