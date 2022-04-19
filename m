Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866FBC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Apr 2022 22:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358225AbiDSWhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Apr 2022 18:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234498AbiDSWhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 18:37:02 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1B42C669;
        Tue, 19 Apr 2022 15:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650407658; x=1681943658;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=vmDxfZNz6aG7ngdmDvO628iJtp0H5B/RiNUqVclA0CE=;
  b=DbntXf5PMFtUaEmNeFTTKcyYTcTqRDvj01abP5M4U501hqgnfV1PWUOs
   qM9TNtuIrtNXmE1YsCx+GbnlH0e1Qi9rVti95paRlrKqJQrH5hYsyY1TD
   jio+zjl5cx9QAJFOsoEkDlQPT5u4OShFxb7JmDqWV5fVnhac1C67vU3//
   8=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 19 Apr 2022 15:34:18 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 15:34:18 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 19 Apr 2022 15:34:17 -0700
Received: from hu-subbaram-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 19 Apr 2022 15:34:17 -0700
From:   Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>
To:     <quic_fenglinw@quicinc.com>
CC:     <quic_collinsd@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <maz@kernel.org>,
        <sboyd@kernel.org>, <quic_subbaram@quicinc.com>,
        <tglx@linutronix.de>
Subject: [PATCH v6 00/10] A bunch of fix and optimization patches in spmi-pmic-arb.c
Date:   Tue, 19 Apr 2022 15:34:11 -0700
Message-ID: <1650407651-10571-1-git-send-email-quic_subbaram@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1647497535-32151-1-git-send-email-quic_fenglinw@quicinc.com>
References: <1647497535-32151-1-git-send-email-quic_fenglinw@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Changes in v6:
>   Rebased [v5 08/10] on 
>     https://lore.kernel.org/linux-arm-msm/20211227170151.73116-1-david@ixit.cz/#t

Hi Stephen,
Can this patch series be reviewed? It would be good to know if something is
missing to keep this pending for a while.

Thanks,
Subbaraman
